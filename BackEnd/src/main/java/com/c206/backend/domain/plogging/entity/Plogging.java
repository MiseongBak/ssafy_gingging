package com.c206.backend.domain.plogging.entity;


import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.domain.pet.entity.MemberPet;
import com.c206.backend.global.common.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class Plogging extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "plogging_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_pet_id")
    private MemberPet memberPet;

    private String time;

    private int distance;

    public void updateTime(String time) {
        this.time += time;
    }

    public void updateDistance(int distance) {
        this.distance = distance;
    }

}
