package com.johnfu.event.repositories;
import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import com.johnfu.event.models.Event;
import com.johnfu.event.models.User;
import com.johnfu.event.models.Message;
public interface MessageRepository extends CrudRepository<Message, Long>{
	List<Message> findAll();
	List<Message> findByEvent(Event event);
}
