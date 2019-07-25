package com.johnfu.event.controllers;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.johnfu.event.models.Event;
import com.johnfu.event.models.Message;
import com.johnfu.event.models.User;
import com.johnfu.event.models.EventUser;
import com.johnfu.event.services.UserService;
import com.johnfu.event.validator.UserValidator;


@Controller
public class EventController {
	private final UserService userService;
	private final UserValidator userValidator;
	public EventController(UserService userService,UserValidator userValidator) {
		this.userService=userService;
		this.userValidator=userValidator;
	}
	@RequestMapping("")
	public String index(@ModelAttribute("user") User user) {
		return "signIn.jsp";
	}
    @RequestMapping(value="/registration", method=RequestMethod.POST)
    public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
        userValidator.validate(user, result);
        if(result.hasErrors()) {
            return "signIn.jsp";
        } else {
        	User u = userService.registerUser(user);
        	session.setAttribute("userId", u);
        	return "redirect:/events";
        }
    }
    @RequestMapping(value="/login", method=RequestMethod.POST)
    public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password,Model model, HttpSession session) {
    	boolean check=userService.authenticateUser(email, password);
    	if (check == false) {
    		return "redirect:";
    	} else {
    		User user=userService.findByEmail(email);
    		session.setAttribute("userId", user);
    		return "redirect:/events";
    	}
    }
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
    	return "redirect:/";
    }
    @RequestMapping("/events")
    public String home(@ModelAttribute("newEventUser") EventUser newEventUser, @ModelAttribute("event") Event event, Model model,HttpSession session) {
    	List<Event> events=userService.findAllEvents();
    	model.addAttribute("events", events);
    	
    	return "index.jsp";
    }
    @RequestMapping(value="/events/add", method=RequestMethod.POST)
    public String addEvent(@Valid @ModelAttribute("event") Event event, BindingResult result) {
        	Event e = userService.addEvent(event);
            return "redirect:/events";
    }
    @RequestMapping("/events/{id}")
    public String showEvent(@PathVariable ("id") Long id, Model model,@ModelAttribute("message") Message message,HttpSession session) {
    	Event event=userService.findEvent(id);
    	List<Message> messages=userService.findMessagesByEvent(event);
    	model.addAttribute("messages", messages);
    	model.addAttribute("event", event);
    	return "showEvent.jsp";
    }
    @RequestMapping("/events/{eventId}/message/add")
    public String addMessage(HttpSession session, @PathVariable("eventId") Long eId, @Valid @ModelAttribute("message") Message message, BindingResult result) {
        Message m=userService.addMessage(message);
        return "redirect:/events/" + eId;
    }
    @RequestMapping("/events/{eventId}/edit")
    public String eventEditForm(@PathVariable("eventId")Long eventId,HttpSession session, Model model) {
    	Event event=userService.findEvent(eventId);
    	model.addAttribute("event", event);
    	return "editEvent.jsp";
    }
    @RequestMapping(value="/events/{eventId}", method=RequestMethod.PUT)
    public String updateEvent(HttpSession session, @PathVariable("eventId") Long eId,@Valid @ModelAttribute("event") Event event,BindingResult result) {
        if (result.hasErrors()) {
            return "editEvent.jsp";
        } else {
            userService.updateEvent(event);
            return "redirect:/events";
        }
    }
    @RequestMapping(value="/events/{eventId}", method=RequestMethod.DELETE)
    public String deleteEvent(HttpSession session, @PathVariable("eventId") Long eventId) {
    	userService.deleteEvent(eventId);
    	return "redirect:/events";
    }
    @RequestMapping("/events/{eventId}/{userId}")
    public String joinEvent(HttpSession session,@ModelAttribute("newEventUser") EventUser newEventUser) {
    	userService.joinEvent(newEventUser);
    	return "redirect:/events";
    }
    @RequestMapping(value="/events/{eventId}/{userId}", method=RequestMethod.DELETE)
	public String dropEvent(HttpSession session, @PathVariable("eventId") Long eId,@PathVariable("userId") Long uId) {
		userService.dropEvent(eId, uId);
		return "redirect:/events";
	}
    
	
}
