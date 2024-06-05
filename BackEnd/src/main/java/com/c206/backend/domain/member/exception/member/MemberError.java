package com.c206.backend.domain.member.exception.member;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum MemberError {

    NOT_FOUND_MEMBER(HttpStatus.INTERNAL_SERVER_ERROR, "해당 회원을 찾을 수 없습니다."),
    EXIST_MEMBER_EMAIL(HttpStatus.INTERNAL_SERVER_ERROR, "이미 가입되어 있는 이메일입니다."),
    ALREADY_MEMBER_LOGOUT(HttpStatus.BAD_REQUEST, "이미 로그아웃 된 회원입니다."),
    NOT_MATCH_PASSWORD(HttpStatus.BAD_REQUEST, "비밀번호가 일치하지 않습니다."),
    CURRENT_CHANGE_MATCH_PASSWORD(HttpStatus.BAD_REQUEST, "현재 비밀번호가 변경하려는 비밀번호와 같습니다."),
    FAIL_TO_MAKE_MEMBER(HttpStatus.BAD_REQUEST, "멤버 생성에 실패했습니다."),
    FAIL_TO_MAKE_BASIC_PET(HttpStatus.BAD_REQUEST, "기본 펫 생성에 실패했습니다."),
    FAIL_TO_MAKE_BASIC_MEMBER_INFO(HttpStatus.BAD_REQUEST, "기본 사용자 정보 생성에 실패했습니다."),
    FAIL_TO_MAKE_BASIC_QUEST(HttpStatus.BAD_REQUEST, "기본 퀘스트 생성에 실패했습니다."),
    FAIL_TO_MAKE_BASIC_ACHIEVEMENT(HttpStatus.BAD_REQUEST, "기본 업적 생성에 실패했습니다.");



    private final HttpStatus httpStatus;
    private final String errorMessage;
}
