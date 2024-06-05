package com.c206.backend.domain.achievement.repository;

import com.c206.backend.domain.achievement.entity.MemberAchievement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemberAchievementRepository extends JpaRepository<MemberAchievement, Long> {
    List<MemberAchievement> findByMemberId(Long memberId);

    MemberAchievement findByMemberIdAndAchievementId(Long memberId, Long achievementId);

}
