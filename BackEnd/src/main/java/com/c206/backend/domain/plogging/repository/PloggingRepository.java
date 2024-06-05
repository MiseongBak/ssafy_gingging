package com.c206.backend.domain.plogging.repository;

import com.c206.backend.domain.plogging.entity.Plogging;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PloggingRepository extends JpaRepository<Plogging,Long> {

    List<Plogging> findByMemberIdOrderByCreatedAtDesc(Long memberId);
}
