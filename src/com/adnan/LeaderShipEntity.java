package com.adnan;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import com.adnan.Type;
import com.google.common.base.Joiner;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class LeaderShipEntity implements Comparable<LeaderShipEntity> {
	@Id public Long id;
	public int viewcount1,viewcount2,viewcount3;
	public String stream1,stream2,stream3;
	@Index public Date entry_createddate ; 

	@SuppressWarnings("unused")
	private LeaderShipEntity() {
	}
	
	public LeaderShipEntity(String st1,String st2,String st3,int vt1,int vt2,int vt3) {		
		stream1 = st1;
		stream2 = st2;
		stream3 = st3;
		viewcount1 = vt1;
		viewcount2 = vt2;
		viewcount3 = vt3;
		this.entry_createddate = new Date();
	}

	@Override
	public int compareTo(LeaderShipEntity other) {
		if (this.entry_createddate.after(other.entry_createddate)) {
			return 1;
		} else if (this.entry_createddate.after(other.entry_createddate)) {
			return -1;
		}
		return 0;
	}


	public String getStream1(){return stream1;}
	public String getStream2(){return stream2;}
	public String getStream3(){return stream3;}
	public int getViewCount1(){return viewcount1;}
	public int getViewCount2(){return viewcount2;}
	public int getViewCount3(){return viewcount3;}
	public Date getCreateDate(){return entry_createddate;}

}