package com.spring.javaclassS.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS.vo.DbProductVO;

public interface DbShopService {

	public DbProductVO getCategoryMainOne(String categoryMainCode, String categoryMainName);

	public int setCategoryMainInput(DbProductVO vo);

	public List<DbProductVO> getCategoryMain();

	public DbProductVO getCategoryMiddleOne(DbProductVO vo);

	public int setCategoryMainDelete(String categoryMainCode);

	public int setCategoryMiddleInput(DbProductVO vo);

	public List<DbProductVO> getCategoryMiddle();

	public DbProductVO getCategorySubOne(DbProductVO vo);

	public int setCategoryMiddleDelete(String categoryMiddleCode);

	public List<DbProductVO> getCategoryMiddleName(String categoryMainCode);

	public List<DbProductVO> getCategorySub();

	public int setCategorySubInput(DbProductVO vo);

	public DbProductVO getCategoryProductName(DbProductVO vo);

	public int setCategorySubDelete(String categorySubCode);

	public int imgCheckProductInput(MultipartFile file, DbProductVO vo);

	public List<DbProductVO> getSubTitle();

	public List<DbProductVO> getDbShopList(String part, String mainPrice);

	public List<DbProductVO> getCategorySubName(String categoryMainCode, String categoryMiddleCode);

}
