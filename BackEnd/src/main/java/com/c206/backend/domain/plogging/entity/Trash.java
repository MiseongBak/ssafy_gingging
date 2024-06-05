package com.c206.backend.domain.plogging.entity;


import com.c206.backend.domain.plogging.entity.enums.TrashType;
import com.c206.backend.global.common.entity.BaseEntity;
import jakarta.persistence.*;
import lombok.*;
import org.locationtech.jts.geom.Point;


@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
public class Trash extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "trash_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "plogging_id")
    private Plogging plogging;

    @Enumerated(EnumType.STRING)
    private TrashType trashType;

    @Column(columnDefinition = "Point", nullable = false)
    private Point location;


    private String image;
}
