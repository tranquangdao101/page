package dao;

import java.util.ArrayList;

import model.SanPham;

public class SanPhamDAO {
	public static ArrayList<SanPham> dsSP = new ArrayList<>();

	public SanPhamDAO() {
		dsSP.removeAll(dsSP);
	}
	public ArrayList<SanPham> khoiTaoGiatri(){
		for (int i = 1; i < 146; i++) {
			dsSP.add(new SanPham("Áo "+i, "AO0"+i, Integer.parseInt("1300")*i+" VNĐ"));
		}
		return dsSP;
	}
	public static ArrayList<SanPham> getDsSP() {
		return dsSP;
	}

	public static void setDsSP(ArrayList<SanPham> dsSP) {
		SanPhamDAO.dsSP = dsSP;
	}
	
}
