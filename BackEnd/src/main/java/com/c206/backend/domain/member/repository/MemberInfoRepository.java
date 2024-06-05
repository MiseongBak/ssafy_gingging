package com.c206.backend.domain.member.repository;


import com.c206.backend.domain.member.entity.MemberInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MemberInfoRepository extends JpaRepository<MemberInfo, Long> {

    MemberInfo findTopByMemberIdOrderByIdDesc(Long memberId);

    List<MemberInfo> findTop10ByOrderByExpDesc();

    @Query(value = "SELECT member_info_id, member_id, profile_pet_id, exp, currency FROM member_info WHERE member_info_id IN (SELECT MAX(member_info_id) FROM member_info GROUP BY member_id) ORDER BY exp DESC LIMIT 10", nativeQuery = true)
    List<MemberInfo> findTop10MostRecentMembersByExpDesc();



}
