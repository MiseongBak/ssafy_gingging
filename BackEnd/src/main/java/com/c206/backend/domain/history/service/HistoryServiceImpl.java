package com.c206.backend.domain.history.service;

import com.c206.backend.domain.history.dto.RouteDto;
import com.c206.backend.domain.history.dto.TrashDto;
import com.c206.backend.domain.history.dto.response.HistoryDetailResponseDto;
import com.c206.backend.domain.history.dto.response.HistoryListResponseDto;
import com.c206.backend.domain.history.exception.HistoryError;
import com.c206.backend.domain.history.exception.HistoryException;
import com.c206.backend.domain.plogging.entity.Plogging;
import com.c206.backend.domain.plogging.entity.PloggingRoute;
import com.c206.backend.domain.plogging.entity.Trash;
import com.c206.backend.domain.plogging.entity.enums.TrashType;
import com.c206.backend.domain.plogging.repository.PloggingRepository;
import com.c206.backend.domain.plogging.repository.PloggingRouteRepository;
import com.c206.backend.domain.plogging.repository.TrashRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class HistoryServiceImpl implements HistoryService{

    private final PloggingRepository ploggingRepository;

    private final TrashRepository trashRepository;

    private final PloggingRouteRepository ploggingRouteRepository;

    @Override
    public List<HistoryListResponseDto> historyList(Long memberId) {

        List<Plogging> ploggingList = ploggingRepository.findByMemberIdOrderByCreatedAtDesc(memberId);

        List<HistoryListResponseDto> historyList = new ArrayList<>();

        for(Plogging plogItem : ploggingList){
            if(plogItem.getDistance() == 0){
                continue;
            }

            //쓰레기
            List<Object[]> results = trashRepository.countTrashByPloggingId(plogItem.getId());
            int TrashCount = 0;
            for (Object[] result : results) {
                TrashCount += ((Number) result[1]).intValue();
            }

            HistoryListResponseDto historyListResponseDto = new HistoryListResponseDto(
                    plogItem.getId(),
                    plogItem.getCreatedAt(),
                    plogItem.getUpdatedAt(),
                    plogItem.getMemberPet().getPet().getId(),
                    plogItem.getDistance(),
                    TrashCount
            );
            historyList.add(historyListResponseDto);
        }

        return historyList;
    }

    @Override
    public HistoryDetailResponseDto historyDetail(Long memberId, Long ploggingId) {

        //플로깅 찾기
        Plogging plogging = ploggingRepository.findById(ploggingId).orElseThrow(() ->
                new HistoryException(HistoryError.NOT_FOUND_PLOGGING));

        // 찾은 플로깅이 회원과 일치하는지 체크
        if(!Objects.equals(plogging.getMember().getId(), memberId)){
            throw new HistoryException(HistoryError.NOT_FOUND_MEMBER_PLOGGING);
        }

        //임의로 쓰레기 데이터 설정. 위도 경도의 자료형은 추후 달라질 수 있다.
        List<TrashDto> trashDtoList = new ArrayList<>();
        List<Trash> trashList = trashRepository.findByPloggingId(ploggingId);

        for(Trash trashItem : trashList){
            TrashDto trashDTO = new TrashDto(
                    trashItem.getLocation().getY(),
                    trashItem.getLocation().getX(),
                    trashItem.getTrashType(),
                    trashItem.getImage()
            );
            trashDtoList.add(trashDTO);
        }

        //임의로 경로 데이터 설정. 위도 경도의 자료형은 추후 달라질 수 있다.
        List<RouteDto> routeDtoList = new ArrayList<>();
        List<PloggingRoute> ploggingRouteList = ploggingRouteRepository.findByPloggingId(ploggingId);

        for(PloggingRoute routeItem : ploggingRouteList){
            RouteDto routeDTO = new RouteDto(
                    routeItem.getLatitude(),
                    routeItem.getLongitude()
            );

            routeDtoList.add(routeDTO);
        }

        //쓰레기 갯수 세기
        List<Object[]> results = trashRepository.countTrashByPloggingId(ploggingId);
        int normal=0,plastic = 0,can=0,glass=0;
        for (Object[] result : results) {
            int count = ((Number) result[1]).intValue();
            switch ((TrashType) result[0]) {
                case NORMAL -> normal = count;
                case PLASTIC -> plastic = count;
                case CAN -> can = count;
                case GLASS -> glass = count;
            }
        }


        return new HistoryDetailResponseDto(
                ploggingId,
                trashDtoList,
                routeDtoList,
                normal,
                plastic,
                can,
                glass
        );
    }
}
