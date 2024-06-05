package com.c206.backend.domain.quest.repository;

import com.c206.backend.domain.quest.entity.MemberQuest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemberQuestRepository extends JpaRepository<MemberQuest, Long> {

    List<MemberQuest> findTop3ByMemberIdOrderByCreatedAtDesc(Long memberId);

    MemberQuest findTopByMemberIdAndMemberPetIdAndQuestIdOrderByIdDesc(Long memberId,Long memberPetId, Long questId);

}
