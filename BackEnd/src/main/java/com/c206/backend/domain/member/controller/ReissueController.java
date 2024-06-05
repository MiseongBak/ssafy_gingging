package com.c206.backend.domain.member.controller;

import com.c206.backend.domain.member.service.ReissueService;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@ResponseBody
@Slf4j
@RequestMapping(value = "/api/v1", produces = "application/json")
@Tag(name = "Reissue", description = "Reissue API")
public class ReissueController {

    private final ReissueService reissueService;

    public ReissueController(ReissueService reissueService) {
        this.reissueService = reissueService;
    }

    @PostMapping("/reissue")
    public ResponseEntity<?> reissue(HttpServletRequest request, HttpServletResponse response) {
        log.info("토큰 재발행 실행");
        return reissueService.reissueRefreshToken(request, response);

    }
}

