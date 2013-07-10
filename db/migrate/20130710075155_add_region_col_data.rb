# encoding: UTF-8
class AddRegionColData < ActiveRecord::Migration
  def up
  
    from = ['Akhalgori', 'ახალგორი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Mtskheta-Mtianeti')

    from = ['Abasha', 'აბაშა']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Samegrelo-Zemo Svaneti')

    from = ['Adigeni', 'ადიგენი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Samtskhe-Javakheti')

    from = ['Chakvi', 'ჩაქვი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Adjara')

    from = ['Gardabani', 'გარდაბანი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Kvemo Kartli')

    from = ['Gori', 'გორი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Shida Kartli')

    from = ['Kaspi', 'კასპი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Shida Kartli')

    from = ['Kharagauli', 'ხარაგაული']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Imereti')

    from = ['Khelvachauri', 'ხელვაჩაური']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Adjara')

    from = ['Khulo', 'ხულო']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Adjara')

    from = ['Kobuleti', 'ქობულეთი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Adjara')

    from = ['Kvareli', 'ყვარელი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Kakheti')

    from = ['Martvili', 'მარტვილი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Samegrelo-Zemo Svaneti')

    from = ['Mestia', 'მესტია']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Samegrelo-Zemo Svaneti')

    from = ['Mtskheta', 'მცხეთა']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Mtskheta-Mtianeti')

    from = ['Ozurgeti', 'ოზურგეთი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Guria')

    from = ['Qeda', 'ქედა']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Adjara')

    from = ['Rustavi', 'რუსთავი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Kvemo Kartli')

    from = ['Samtredia', 'სამტრედია']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Imereti')

    from = ['Senaki', 'სენაკი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Samegrelo-Zemo Svaneti')

    from = ['Svaneti', 'სვანეთი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Samegrelo-Zemo Svaneti')

    from = ['Tbilisi', 'თბილისი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Tbilisi')

    from = ['Tsalenjikha', 'წალენჯიხა']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Samegrelo-Zemo Svaneti')

    from = ['Vani', 'ვანი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Imereti')

    from = ['Zugdidi', 'ზუგდიდი']
    SoldierTranslation.where(:place_from => from).update_all(:region_from => 'Samegrelo-Zemo Svaneti')
    
  end

  def down
    SoldierTranslation.update_all(:region_from => nil)
  end
end
