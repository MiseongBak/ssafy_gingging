package com.c206.backend.global.exception;

import com.c206.backend.global.common.dto.Message;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionAdvice {

    /**
     * 권한없는 사용자 요청 처리
     * @param exception
     * @return
     */
    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<Message<Void>> accessDeniedExceptionHandle(AccessDeniedException exception) {
        log.warn("인가에러 ex : {}", (Object[]) exception.getStackTrace());

        return ResponseEntity.status(GlobalError.FORBIDDEN_EXCEPTION.getHttpStatus())
                .body(Message.fail(null, GlobalError.FORBIDDEN_EXCEPTION.getErrorMessage()));
    }

    /**
     * 인증되지 않은 사용자 요청 처리
     * @param exception
     * @return
     */
    @ExceptionHandler(AuthenticationException.class)
    public ResponseEntity<Message<Void>>  authenticationExceptionHandle(AuthenticationException exception) {
        log.warn("인증에러 ex : {}", (Object[]) exception.getStackTrace());

        return ResponseEntity.status(GlobalError.AUTHENTICATION_EXCEPTION.getHttpStatus())
                .body(Message.fail(null, GlobalError.AUTHENTICATION_EXCEPTION.getErrorMessage()));
    }

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public ResponseEntity<Message<Void>> handleMaxUploadSizeExceededException(MaxUploadSizeExceededException exception) {
        log.warn("파일 업로드 에러 ex : {}", (Object[]) exception.getStackTrace());
        return ResponseEntity.status(GlobalError.MAXIMUM_UPLOAD_SIZE.getHttpStatus())
                .body(Message.fail(null, GlobalError.MAXIMUM_UPLOAD_SIZE.getErrorMessage()));
    }

    @ExceptionHandler(GlobalException.class)
    public ResponseEntity<Message<Void>> GlobalException(GlobalException e) {
        log.error("커스텀 에러 ex : {}", e.getMessage());
        return ResponseEntity.status(e.getStatus()).body(Message.fail(null, e.getErrorMessage()));
    }

    /**
     * 기본 에러 처리
     * @param exception
     * @return
     */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<Message<Void>>  defaultExceptionHandle(Exception exception) {
        log.warn("기본에러 ex : {}", (Object[]) exception.getStackTrace());

        return ResponseEntity.status(GlobalError.DEFAULT_EXCEPTION.getHttpStatus())
                .body(Message.fail(null, GlobalError.DEFAULT_EXCEPTION.getErrorMessage()));
    }
}
