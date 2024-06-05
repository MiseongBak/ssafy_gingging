package com.c206.backend.domain.plogging.repository;

import com.c206.backend.domain.plogging.entity.PloggingRoute;
import com.c206.backend.domain.plogging.entity.Trash;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PloggingRouteRepository extends JpaRepository<PloggingRoute, Long> {
    List<PloggingRoute> findByPloggingId(Long ploggingId);



}
