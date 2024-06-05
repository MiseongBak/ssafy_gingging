package com.c206.backend.domain.quest.repository;

import com.c206.backend.domain.quest.entity.Quest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface QuestRepository extends JpaRepository<Quest, Long> {

}
