package com.c206.backend.domain.member.controller;

import com.c206.backend.domain.member.dto.request.SignInRequestDto;
import com.c206.backend.domain.member.dto.request.SignUpRequestDto;
import com.c206.backend.domain.member.dto.response.MemberTrashCountResDto;
import com.c206.backend.domain.member.service.MemberService;
import com.c206.backend.global.common.dto.Message;
import com.c206.backend.global.jwt.CustomUserDetails;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Slf4j
@RestController
@RequestMapping(value = "/api/v1/member", produces = "application/json")
@Tag(name = "Member", description = "Member API")
public class MemberController {

    private final MemberService memberService;

    public MemberController(MemberService memberService){
        this.memberService = memberService;
    }


    @PostMapping(value = "/signin")
    @Operation(summary = "로그인을 진행합니다.")
    public ResponseEntity<?> loginP(@RequestBody @Valid @Parameter SignInRequestDto signInRequestDto // HashMap<String, Object> map
    ){
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/signup")
    @Operation(summary = "회원가입을 진행합니다." )
    public ResponseEntity<Message<?>> memberSignUp(@RequestBody @Valid @Parameter SignUpRequestDto signUpRequestDto, Errors error){
        if (error.hasErrors()) {
            // 바인딩 결과에 에러가 있으면 에러 메시지를 반환
            return ResponseEntity.badRequest().body((Message.success(error.getAllErrors().toString())));
        }
        try {
            System.out.println(signUpRequestDto.getEmail());
            System.out.println(signUpRequestDto.getNickname());
            boolean isSuccess = memberService.signUpProcess(signUpRequestDto);

            if(isSuccess){
                return ResponseEntity.ok().body(Message.success(isSuccess));
            }else{
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
            }

        }catch (Exception e)
        {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();  // HTTP 500 응답
        }
    }

    @GetMapping("/info")
    @Operation(summary = "유저 정보를 열람합니다.")
    public ResponseEntity<Message<?>> getMemberInfo(@Parameter(hidden = true)Authentication authentication){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();

        MemberTrashCountResDto memberTrashCountResDto = memberService.getMemberInfo(memberId);

        return ResponseEntity.ok().body(Message.success(memberTrashCountResDto));
    }

    @PostMapping("/updateprofile/{profilePetId}")
    @Operation(summary = "유저 프로필 사진을 업데이트합니다.")
    public ResponseEntity<Message<?>> updateProfilePic(@Parameter(hidden = true)Authentication authentication, @PathVariable("profilePetId") Long profilePetId){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();

        boolean isUpdated = memberService.updateMemberInfoPicture(memberId, profilePetId);

        return ResponseEntity.ok().body(Message.success(isUpdated));
    }


    @PostMapping()
    @Operation(summary = "이메일 중복체크를 진행합니다.")
    public ResponseEntity<Message<?>> memberEmailDupCheck(@RequestBody @Parameter String email){

        try{
            System.out.println(memberService.emailDupCheck(email));
            return ResponseEntity.ok().body(Message.success());
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

    }

    @PostMapping("/tutorial")
    @Operation(summary = "튜토리얼 진행 완료시 호출됩니다.")
    public ResponseEntity<Message<?>> tutorialCheck(@Parameter(hidden = true) Authentication authentication){
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        Long memberId = customUserDetails.getId();

        boolean isTutorial = memberService.updateMemberTutorial(memberId);

        return ResponseEntity.ok().body(Message.success(isTutorial));

    }
}
