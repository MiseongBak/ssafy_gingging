package com.c206.backend.domain.notice.service;

import com.c206.backend.domain.notice.dto.response.NoticeListResponseDto;

import java.util.List;

public interface NoticeService {

    List<NoticeListResponseDto> noticeList();
}
