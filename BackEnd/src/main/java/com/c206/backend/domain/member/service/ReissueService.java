package com.c206.backend.domain.member.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public interface ReissueService {

    ResponseEntity<?> reissueRefreshToken(HttpServletRequest request, HttpServletResponse response);
}
