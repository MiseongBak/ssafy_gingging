package com.c206.backend.domain.pet.entity;

import com.c206.backend.domain.member.entity.Member;
import com.c206.backend.global.common.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class MemberPet extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_pet_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "pet_id")
    private Pet pet;

    private int exp;

    private String nickname;

    private boolean active;

    private int normal;

    private int plastic;

    private int can;

    private int glass;

    public void updateNickname(String nickname) {
        this.nickname = nickname;
    }

    public void addExp(int exp) {
        this.exp += exp;
    }

    public void updateActive() {
        this.active = true;
    }

    public void addNormal() {
        this.normal += 1;
    }

    public void addPlastic() {
        this.plastic += 1;
    }

    public void addCan() {
        this.can += 1;
    }
    public void addGlass() {
        this.glass += 1;
    }
}
