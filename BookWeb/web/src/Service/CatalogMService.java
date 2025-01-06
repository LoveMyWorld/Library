package Service;

import Dao.CatalogMDao;
import Dao.LiutongDao;
import Dao.YanshouDao;
import Entity.Cataloglist;
import Entity.Liutong;
import Entity.Yanshou;

public class CatalogMService {
    //得到编目书籍的所有信息，如果能找到就传回编目清单或流通库的书籍，如果没有找到，就把验收清单此本书传回
//从编目清单中找书
    //其实都是通过验收i清单导出信息
    //验收i清单所有的信息都传给后端，这样编目清单表格中的空缺就只有图书编号，册数和分类号了

    public Yanshou getYanshouInfo() {
        YanshouDao yanshouDao = new YanshouDao();
        Yanshou yanshou = yanshouDao.findBooksBySearchOneLine("isbianmu", "false");

        if (yanshou != null) {
            // 如果找到了符合条件的 Yanshou 对象，可以在这里进行进一步的处理
            // 例如，打印日志、设置其他属性等
            System.out.println("Found Yanshou: " + yanshou.getTitle());
        } else {
            // 如果没有找到符合条件的 Yanshou 对象，可以在这里进行相应的处理
            // 例如，打印日志、抛出异常等
            System.out.println("No Yanshou found with isbianmu=false");
        }

        return yanshou;
    }

    //验收清单传回ISBN

    //先在编目清单中找，找到：册数+1，传回图书编号和分类号;未找到：去流通库表中找
    public Cataloglist getCatalogInfo(String ISBN) {
        CatalogMDao catalogMDao = new CatalogMDao();
        // 从编目清单中查找书籍信息
        Cataloglist cataloglist = catalogMDao.findDataByISBN(ISBN);
        // 如果在编目清单中找到了书籍信息，直接返回
        if (cataloglist != null) {
            return cataloglist;
        }
        else return null;
    }
    //在流通库表中取数据，找到：册数1，传回图书编号和分类号;未找到：手动编目
    public Liutong getLiutongInfo(String ISBN) {
        LiutongDao liutongDao = new LiutongDao();
        Liutong liutong = liutongDao.findDataByISBN(ISBN);
        if(liutong != null) {
            return liutong;
        }
        else return null;
    }
    //将这几个函数融合
    public Cataloglist getCatalogInfoWithFallback() {
//        YanshouDao yanshouDao = new YanshouDao();
//
//        LiutongDao liutongDao = new LiutongDao();

        // 从验收清单中获取数据
        Yanshou yanshou = getYanshouInfo();

        if (yanshou == null) {
            System.out.println("不存在未编目书籍");
            return null; // 如果验收清单中没有数据，直接返回 null
        }
        Cataloglist cataloglistnew = new   Cataloglist();
        cataloglistnew.setTitle(yanshou.getTitle());
        cataloglistnew.setAuthor(yanshou.getAuthor());
        cataloglistnew.setISBN(yanshou.getISBN());
        cataloglistnew.setPublicationDate(yanshou.getPublicationDate());
        cataloglistnew.setPublisher(yanshou.getPublisher());
        cataloglistnew.setSupplier(yanshou.getSupplier());
        cataloglistnew.setCurrencyID(yanshou.getCurrencyID());
        cataloglistnew.setPrice(yanshou.getPrice());
        cataloglistnew.setBookNum(yanshou.getSubscribeNum());//暂时还是等于征订册数的
        cataloglistnew.setDocumentType(yanshou.getDocumentType());
        // 尝试从编目清单中获取数据
        Cataloglist cataloglist = getCatalogInfo(yanshou.getISBN());
        if (cataloglist != null) {
            // 如果在编目清单中找到了数据，返回该数据
            cataloglistnew.setBookNum((cataloglist.getBookNum())+1);
            cataloglistnew.setBookID(cataloglist.getBookID());
            cataloglistnew.setCategoryName(cataloglist.getCategoryName());
            return cataloglistnew;
        }

        // 如果编目清单中没有数据，尝试从流通库表中获取数据
        Liutong liutong = getLiutongInfo(yanshou.getISBN());
        if (liutong != null) {
//            cataloglistnew.setBookNum(1);应该不用设吧，征订册数毕竟不一定一本，可以保留验收清单的册数
            cataloglistnew.setBookID(cataloglist.getBookID());
            cataloglistnew.setCategoryName(cataloglist.getCategoryName());
            return cataloglistnew;
        }

        return cataloglistnew;
    }


}
