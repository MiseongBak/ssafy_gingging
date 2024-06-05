package com.c206.backend.domain.plogging.entity;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class Trashcan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "trashcan_id")
    private Long id;

    private double latitude;

    private double longitude;

    private String detail;

    private String trashcanType;

}
