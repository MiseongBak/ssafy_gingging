package com.c206.backend.domain.ranking.service;

import com.c206.backend.domain.member.entity.MemberInfo;
import com.c206.backend.domain.member.repository.MemberInfoRepository;
import com.c206.backend.domain.ranking.dto.response.RankingListResponseDto;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class RankingServiceImpl implements RankingService {

    private final MemberInfoRepository memberInfoRepository;

    @Override
    public List<RankingListResponseDto> rankingList() {

        List<MemberInfo> memberInfoListTop10 = memberInfoRepository.findTop10MostRecentMembersByExpDesc();

        List<RankingListResponseDto> rankingLIst = new ArrayList<>();

        for(MemberInfo memberInfoItem : memberInfoListTop10){
            RankingListResponseDto rankingItem = new RankingListResponseDto(
                    memberInfoItem.getMember().getNickname(),
                    memberInfoItem.getExp()/1000,
                    memberInfoItem.getExp(),
                    memberInfoItem.getProfilePetId()
            );

            rankingLIst.add(rankingItem);
        }

        return rankingLIst;
    }
}
