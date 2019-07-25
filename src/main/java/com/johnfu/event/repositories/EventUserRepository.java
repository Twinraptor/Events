package com.johnfu.event.repositories;
import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.johnfu.event.models.User;
import com.johnfu.event.models.EventUser;
import com.johnfu.event.models.Event;

@Repository
public interface EventUserRepository extends CrudRepository<EventUser, Long>{
	List<EventUser> findAll();
	EventUser findByEventAndUser(Event event,User user);
}

