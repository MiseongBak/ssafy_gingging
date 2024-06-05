package com.c206.backend.domain.pet.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum PetError {

    NOT_FOUND_MEMBER_PET(HttpStatus.INTERNAL_SERVER_ERROR, "해당 펫을 찾을 수 없습니다."),
    CURRENCY_SHORTAGE(HttpStatus.BAD_REQUEST, "보유 통화 부족"),
    PET_OWNERSHIP_COMPLETE(HttpStatus.BAD_REQUEST, "이미 모든 펫을 보유하고 있습니다"),
    NOT_FOUND_PET(HttpStatus.INTERNAL_SERVER_ERROR, "존재하지 않는 펫입니다."),
    NOT_MATCH_PET(HttpStatus.BAD_REQUEST, "로그인한 회원의 펫이 아닙니다."),
    NOT_FOUND_PET_IN_REDIS(HttpStatus.INTERNAL_SERVER_ERROR, "해당 펫의 아이디가 redis에 존재하지 않습니다"),
    NOT_ACTIVE_PET(HttpStatus.INTERNAL_SERVER_ERROR, "해당 펫을 보유하고 있지 않습니다");

    private final HttpStatus httpStatus;
    private final String errorMessage;
}
