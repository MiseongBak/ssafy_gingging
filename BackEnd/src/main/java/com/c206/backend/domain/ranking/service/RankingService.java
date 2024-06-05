package com.c206.backend.domain.ranking.service;

import com.c206.backend.domain.ranking.dto.response.RankingListResponseDto;

import java.util.List;

public interface RankingService {

    List<RankingListResponseDto> rankingList();
}
