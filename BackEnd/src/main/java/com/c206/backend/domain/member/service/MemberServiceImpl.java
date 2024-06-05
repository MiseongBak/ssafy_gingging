package com.c206.backend.domain.member.service;

import com.c206.backend.domain.achievement.entity.Achievement;
import com.c206.backend.domain.achievement.entity.MemberAchievement;
import com.c206.backend.domain.achievement.repository.AchievementRepository;
import com.c206.backend.domain.achievement.repository.MemberAchievementRepository;
import com.c206.backend.domain.member.dto.response.MemberTrashCountResDto;
import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.domain.member.entity.MemberInfo;
import com.c206.backend.domain.member.exception.member.MemberError;
import com.c206.backend.domain.member.exception.member.MemberException;
import com.c206.backend.domain.member.repository.MemberInfoRepository;
import com.c206.backend.domain.pet.dto.response.MemberPetDetailResponseDto;
import com.c206.backend.domain.pet.dto.response.MemberPetListResponseDto;
import com.c206.backend.domain.pet.dto.response.PetListResponseDto;
import com.c206.backend.domain.pet.exception.PetError;
import com.c206.backend.domain.pet.exception.PetException;
import com.c206.backend.domain.pet.service.MemberPetService;
import com.c206.backend.domain.quest.service.MemberQuestService;
import com.c206.backend.domain.member.dto.request.SignUpRequestDto;
import com.c206.backend.domain.member.repository.MemberRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

    private final MemberRepository memberRepository;
    private final MemberInfoRepository memberInfoRepository;
    private final AchievementRepository achievementRepository;
    private final MemberAchievementRepository memberAchievementRepository;
    private final MemberPetService memberPetService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final MemberQuestService memberQuestService;
    private final RedisService redisService;

    @Override
    public Boolean signUpProcess(SignUpRequestDto signupDto) {

        String email = signupDto.getEmail();
        String password = signupDto.getPassword();

        Optional<Member> isExist = memberRepository.findByEmail(email);

        if(isExist.isPresent()){
            throw new MemberException(MemberError.EXIST_MEMBER_EMAIL);
        }else{

            //회원가입
            try{
                signupDto.setPassword(bCryptPasswordEncoder.encode(password));
                memberRepository.save(signupDto.toEntity());
            }catch(Exception e){
                throw new MemberException(MemberError.FAIL_TO_MAKE_MEMBER);
            }

            Optional<Member> nowMember = memberRepository.findByEmail(email);
            if(nowMember.isEmpty()){
                return false;
            }

            Member member = memberRepository.findById(nowMember.get().getId()).orElseThrow(()
                    -> new MemberException(MemberError.NOT_FOUND_MEMBER));


            //회원-정보 테이블에 기본사항 지정하기
            try{
                MemberInfo newMemberInfo= MemberInfo.builder()
                        .member(member)
                        .profilePetId(0L)
                        .exp(0)
                        .currency(0)
                        .build();
                memberInfoRepository.save(newMemberInfo);
            }catch (Exception e){
                throw new MemberException(MemberError.FAIL_TO_MAKE_BASIC_MEMBER_INFO);
            }

            //회원-업적 테이블에 기본사항 지정하기
            try{
                List<Achievement> achievementList = achievementRepository.findAll();
                for (Achievement achievement : achievementList) {
                    MemberAchievement newMemberAchievement = MemberAchievement.builder()
                            .member(member)
                            .achievement(achievement)
                            .progress(0)
                            .goalMultiply(1)
                            .build();
                    memberAchievementRepository.save(newMemberAchievement);
                }
            }catch (Exception e){
                throw new MemberException(MemberError.FAIL_TO_MAKE_BASIC_ACHIEVEMENT);
            }


            memberPetService.provideBasePet(member);

            //기본펫 1번 지급
            try{
                List<MemberPetListResponseDto> memberPetList = memberPetService.getMemberPetList(member.getId());

                redisService.setValues("latest pet id "+ nowMember.get().getId(), String.valueOf(memberPetList.get(0).getMemberPetId()), 14*24*60*60*1000L);
            }catch (Exception e){
                throw new MemberException(MemberError.FAIL_TO_MAKE_BASIC_PET);
            }

            //회원-퀘스트 테이블에 기본사항 지정하기
            try{
                memberQuestService.addQuestList(member.getId());
            }catch (Exception e){
                throw new MemberException(MemberError.FAIL_TO_MAKE_BASIC_QUEST);
            }


            return true;
        }
    }

    @Override
    public Boolean emailDupCheck(String email) {
        return memberRepository.existsByEmail(email);
    }

    @Override
    public MemberTrashCountResDto getMemberInfo(Long memberId) {

        Member member = memberRepository.findById(memberId).orElseThrow(()->
                new MemberException(MemberError.NOT_FOUND_MEMBER));

        MemberInfo memberInfo = memberInfoRepository.findTopByMemberIdOrderByIdDesc(memberId);

        List<MemberPetListResponseDto> memberPetList = memberPetService.getMemberPetList(memberId);
        int totalTrashNormal = 0, totalTrashPlastic = 0, totalTrashCan = 0, totalTrashGlass = 0;
        for(MemberPetListResponseDto memberPetItem : memberPetList){
            MemberPetDetailResponseDto memberPetDetail = memberPetService.getMemberPetDetail(memberId, memberPetItem.getMemberPetId(), false);
            totalTrashNormal += memberPetDetail.getNormal();
            totalTrashPlastic += memberPetDetail.getPlastic();
            totalTrashCan += memberPetDetail.getCan();
            totalTrashGlass += memberPetDetail.getGlass();
        }

        return new MemberTrashCountResDto(
                member.getEmail(),
                member.getNickname(),
                memberInfo.getProfilePetId(),
                memberInfo.getExp()/1000,
                memberInfo.getCurrency(),
                totalTrashNormal,
                totalTrashPlastic,
                totalTrashCan,
                totalTrashGlass
        );
    }

    @Override
    public boolean updateMemberInfoPicture(Long memberId, Long profilePetId) {
        MemberInfo memberInfo;
        try{
            memberInfo = memberInfoRepository.findTopByMemberIdOrderByIdDesc(memberId);
        }catch (Exception e){
            throw new MemberException(MemberError.NOT_FOUND_MEMBER);
        }


        List<PetListResponseDto> petList = memberPetService.getPetList(memberId);
        try{
            petList = memberPetService.getPetList(memberId);
        }catch (Exception e){
            throw new PetException(PetError.NOT_FOUND_MEMBER_PET);
        }


        if(profilePetId <= 0 || profilePetId > petList.size()){
            throw new PetException(PetError.NOT_FOUND_PET);
        }

        if(!petList.get(profilePetId.intValue() - 1).isActive()){
            throw new PetException(PetError.NOT_ACTIVE_PET);
        }


        memberInfo.updateProfilePetId(profilePetId);
        memberInfoRepository.save(memberInfo);
        return true;
    }

    @Override
    public boolean updateMemberTutorial(Long memberId) {

        Member member = memberRepository.findById(memberId).orElseThrow(()
                -> new MemberException(MemberError.NOT_FOUND_MEMBER)
        );
        member.updateMemberTutorial();

        return true;
    }


}
