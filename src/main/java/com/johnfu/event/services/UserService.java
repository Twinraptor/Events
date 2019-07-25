package com.johnfu.event.services;

import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.johnfu.event.models.Event;
import com.johnfu.event.models.EventUser;
import com.johnfu.event.models.Message;
import com.johnfu.event.models.User;
import com.johnfu.event.repositories.EventRepository;
import com.johnfu.event.repositories.MessageRepository;
import com.johnfu.event.repositories.UserRepository;
import com.johnfu.event.repositories.EventUserRepository;
@Service
public class UserService {
    private final UserRepository userRepository;
    private final EventRepository eventRepository;
    private final MessageRepository messageRepository;
    private final EventUserRepository eventUserRepository;    
    public UserService(EventUserRepository eventUserRepository, MessageRepository messageRepository, UserRepository userRepository,EventRepository eventRepository) {
        this.userRepository = userRepository;
        this.eventRepository = eventRepository;
        this.messageRepository= messageRepository;
        this.eventUserRepository= eventUserRepository;
    }
    
    // register user and hash their password
    public User registerUser(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepository.save(user);
    }
    
    // find user by email
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    // find user by id
    public User findUserById(Long id) {
    	Optional<User> u = userRepository.findById(id);
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    
    // authenticate user
    public boolean authenticateUser(String email, String password) {
        // first find the user by email
        User user = userRepository.findByEmail(email);
        // if we can't find it by email, return false
        if(user == null) {
            return false;
        } else {
            // if the passwords match, return true, else, return false
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }
    public Event addEvent(Event event) {
    	return eventRepository.save(event);
    }

	public List<Event> findAllEvents() {
		List<Event> events=eventRepository.findAll();
		return events;
	}
	public List<Event> findInstateEvents(String state){
		List<Event> inState=eventRepository.findByState(state);
		return inState;
	}
	public List<Event> findOutstateEvents(String state){
		List<Event> outState=eventRepository.findByStateNot(state);
		return outState;
	}
	public Event findEvent(Long id) {
		Optional<Event> optionalEvent= eventRepository.findById(id);
		if(optionalEvent.isPresent()) {
			return optionalEvent.get();
		} else {
			return null;
		}
	}

	public Message addMessage(Message message) {
		return messageRepository.save(message);
	}
	public List<Message> findAllMessages(){
		return messageRepository.findAll();
	}

	public List<Message> findMessagesByEvent(Event event) {
		return messageRepository.findByEvent(event);
	}

	public Event updateEvent(Event event) {
		return eventRepository.save(event);
	}
	public void deleteEvent(Long id) {
		Event temp=findEvent(id);
		eventRepository.delete(temp);
		return;
	}

	public void joinEvent(EventUser newEventUser) {
		eventUserRepository.save(newEventUser);
		return;
	}
	public void dropEvent(Long eId, Long uId) {
		User user=findUserById(uId);
		Event event=findEvent(eId);
		EventUser temp=eventUserRepository.findByEventAndUser(event, user);
		eventUserRepository.delete(temp);
		return;
	}

}
