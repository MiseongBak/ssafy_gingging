package com.c206.backend.domain.pet.repository;

import com.c206.backend.domain.pet.entity.Pet;
import com.c206.backend.domain.pet.entity.enums.PetType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PetRepository extends JpaRepository<Pet, Long> {

    List<Pet> findByPetTypeIs(PetType petType);
}
