package com.c206.backend.domain.achievement.repository;

import com.c206.backend.domain.achievement.entity.Achievement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository

public interface AchievementRepository extends JpaRepository<Achievement, Long> {
}
