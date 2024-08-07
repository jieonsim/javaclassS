package com.spring.javaclassS.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.ChartVO;
import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.KakaoAddressVO;
import com.spring.javaclassS.vo.MemberVO;
import com.spring.javaclassS.vo.QrCodeVO;
import com.spring.javaclassS.vo.TransactionVO;
import com.spring.javaclassS.vo.UserVO;

public interface StudyDAO {

	public ArrayList<String> getUserMids();

	public HashMap<Object, Object> getUserDetails(@Param("mid") String mid);

	public UserVO getUserMidSearch(@Param("mid") String mid);

	public ArrayList<UserVO> getUserMidList(@Param("mid") String mid);

	public void setSaveCrimeDate(@Param("vo") CrimeVO vo);

	public void setDeleteCrimeDate(@Param("year") int year);

	public ArrayList<CrimeVO> getListCrimeDate(@Param("year") int year);

	public ArrayList<CrimeVO> getYearPoliceCheck(@Param("year") int year, @Param("police") String police,
			@Param("yearOrder") String yearOrder);

	public CrimeVO getAnalyzeTotal(@Param("year") int year, @Param("police") String police);

	public List<MemberVO> getMemberDetails();

	public KakaoAddressVO getKakaoAddressSearch(@Param("address") String address);

	public void setKakaoAddressInput(@Param("vo") KakaoAddressVO vo);

	public List<KakaoAddressVO> getKakaoAddressList();

	public int setKakaoAddressDelete(@Param("address") String address);

	public void setQrCodeCreate(@Param("vo") QrCodeVO vo);

	public QrCodeVO getQrCodeSearch(@Param("qrCode") String qrCode);

	public List<ChartVO> getRecentlyVisitCount(@Param("i") int i);

	public List<TransactionVO> getTransactionList();

	public int setTransactionUserInput(@Param("vo") TransactionVO vo);

	public List<TransactionVO> getTransactionList2();

	public void setTransactionListUser1Input(@Param("vo") TransactionVO vo);

	public void setTransactionListUser2Input(@Param("vo") TransactionVO vo);

	public void setTransactiontUserTotalInput(@Param("vo") TransactionVO vo);
}
