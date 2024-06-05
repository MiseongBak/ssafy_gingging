package com.c206.backend.domain.achievement.entity;

import com.c206.backend.domain.achievement.entity.enums.Reward;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class Achievement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "achievement_id")
    private Long id;

    @Enumerated(EnumType.STRING)
    private Reward reward;

    private int goalCoefficient;

}
