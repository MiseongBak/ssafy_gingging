package com.c206.backend.domain.achievement.entity;

import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.global.common.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class MemberAchievement extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_achievement_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "achievement_id")
    private Achievement achievement;

    private int progress;

    private int goalMultiply;

    public void updateProgress(int progress) {
        this.progress +=progress;
    }

    public void updateGoalMultiply() {
        this.goalMultiply+=1;
    }

}

