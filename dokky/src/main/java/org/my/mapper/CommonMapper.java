package org.my.mapper;
	import java.util.List;
	import org.my.domain.Criteria;
	import org.my.domain.VisitCountVO;
	import org.my.domain.alarmVO;
	import org.my.domain.noteVO;

public interface CommonMapper {

	public int insertVisitor(VisitCountVO vo);

	public int getVisitTodayCount();

	public int getVisitTotalCount();

	public int getAlarmCount(Criteria cri);

	public List<alarmVO> getAllAlarmList(Criteria cri);

	public int insertAlarm(alarmVO vo);
	
	public int deleteAlarm(alarmVO vo);

	public String getAlarmRealCount(String userId);

	public int updateAlarmCheck(String alarmNum);

	public int deleteAllAlarm(Long alarmNum);
	
	public int deleteMyNote(Long note_num);

	public List<noteVO> getFromNoteList(Criteria cri);

	public int getFromNoteCount(Criteria cri);

	public int getToNoteCount(Criteria cri);

	public int getMyNoteCount(Criteria cri);

	public int insertNote(noteVO vo);

	public int updateNoteCheck(String note_num);

	public noteVO getDetailNotepage(Long note_num);

	public int updateFromNote(Long note_num);

	public int updateToNote(Long note_num);

	public List<noteVO> getToNoteList(Criteria cri);

	public List<noteVO> getMyNoteList(Criteria cri);

	public String getNoteCount(String userId);

	public int getAlarmReadCount(Criteria cri);

	public List<alarmVO> getReadedAlarmList(Criteria cri);

	public List<alarmVO> getNotReadedAlarmList(Criteria cri);

	public int getEnabled(String userId);
	
	public String tests1();
	public String tests2();
	public String tests3();
	public String tests4();
	public String tests5();
	public String tests6();
}
