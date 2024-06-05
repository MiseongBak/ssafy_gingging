package com.c206.backend.domain.notice.exception;

import com.c206.backend.global.common.dto.Message;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class NoticeExceptionHandler {
    @ExceptionHandler(NoticeException.class)
    public ResponseEntity<Message<Void>> memberException(NoticeException e) {
        log.error("{} is occurred", e.getMessage());
        return ResponseEntity.status(e.getStatus()).body(Message.fail(null, e.getErrorMessage()));
    }
}
