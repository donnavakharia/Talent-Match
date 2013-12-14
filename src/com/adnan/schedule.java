package com.adnan;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class schedule {
	@Id public Long id;
	public String selectedSchedule;
	
	@SuppressWarnings("unused")
	private schedule() {
	}
	
	public schedule(String us){
		selectedSchedule = us;
	}

}
