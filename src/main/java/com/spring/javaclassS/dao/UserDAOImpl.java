package com.spring.javaclassS.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.javaclassS.vo.UserVO;

@Repository("userDAO")
public class UserDAOImpl implements UserDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<UserVO> getUserList() {
		List<UserVO> vos = sqlSession.selectList("userNS.getUserList");
		return vos;
	}

	@Override
	public int setUserDelete(int idx) {
		return sqlSession.delete("userNS.setUserDelete", idx);
	}

	@Override
	public int setUserInputOk(UserVO vo) {
		return sqlSession.insert("userNS.setUserInputOk", vo);
	}

	@Override
	public List<UserVO> getUserIdSearch(String mid) {
		return sqlSession.selectList("userNS.getUserIdSearch", mid);
	}

	@Override
	public int setUserUpdateOk(UserVO vo) {
		return sqlSession.update("userNS.setUserUpdateOk", vo);
	}
	
}
