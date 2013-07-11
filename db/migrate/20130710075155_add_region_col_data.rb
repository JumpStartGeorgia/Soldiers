# encoding: UTF-8
class AddRegionColData < ActiveRecord::Migration
  require 'json_cache'
  def up
  
    SoldierTranslation.where(:place_from => 'Akhalgori').update_all(:region_from => 'Mtskheta-Mtianeti')
    SoldierTranslation.where(:place_from => 'ახალგორი').update_all(:region_from => 'მცხეთა-მთიანეთი')

    SoldierTranslation.where(:place_from => 'Abasha').update_all(:region_from => 'Samegrelo-Zemo Svaneti')
    SoldierTranslation.where(:place_from => 'აბაშა').update_all(:region_from => 'სამეგრელი-ზემო სვანეთი')

    SoldierTranslation.where(:place_from => 'Adigeni').update_all(:region_from => 'Samtskhe-Javakheti')
    SoldierTranslation.where(:place_from => 'ადიგენი').update_all(:region_from => 'სამცხე-ჯავახეთი')

    SoldierTranslation.where(:place_from => 'Chakvi').update_all(:region_from => 'Adjara')
    SoldierTranslation.where(:place_from => 'ჩაქვი').update_all(:region_from => 'აჭარა')

    SoldierTranslation.where(:place_from => 'Gardabani').update_all(:region_from => 'Kvemo Kartli')
    SoldierTranslation.where(:place_from => 'გარდაბანი').update_all(:region_from => 'ქვემო ქართლი')

    SoldierTranslation.where(:place_from => 'Gori').update_all(:region_from => 'Shida Kartli')
    SoldierTranslation.where(:place_from => 'გორი').update_all(:region_from => 'შიდა ქართლი')

    SoldierTranslation.where(:place_from => 'Kaspi').update_all(:region_from => 'Shida Kartli')
    SoldierTranslation.where(:place_from => 'კასპი').update_all(:region_from => 'შიდა ქართლი')

    SoldierTranslation.where(:place_from => 'Kharagauli').update_all(:region_from => 'Imereti')
    SoldierTranslation.where(:place_from => 'ხარაგაული').update_all(:region_from => 'იმერეთი')

    SoldierTranslation.where(:place_from => 'Khelvachauri').update_all(:region_from => 'Adjara')
    SoldierTranslation.where(:place_from => 'ხელვაჩაური').update_all(:region_from => 'აჭარა')

    SoldierTranslation.where(:place_from => 'Khulo').update_all(:region_from => 'Adjara')
    SoldierTranslation.where(:place_from => 'ხულო').update_all(:region_from => 'აჭარა')

    SoldierTranslation.where(:place_from => 'Kobuleti').update_all(:region_from => 'Adjara')
    SoldierTranslation.where(:place_from => 'ქობულეთი').update_all(:region_from => 'აჭარა')

    SoldierTranslation.where(:place_from => 'Kvareli').update_all(:region_from => 'Kakheti')
    SoldierTranslation.where(:place_from => 'ყვარელი').update_all(:region_from => 'კახეთი')

    SoldierTranslation.where(:place_from => 'Martvili').update_all(:region_from => 'Samegrelo-Zemo Svaneti')
    SoldierTranslation.where(:place_from => 'მარტვილი').update_all(:region_from => 'სამეგრელი-ზემო სვანეთი')

    SoldierTranslation.where(:place_from => 'Mestia').update_all(:region_from => 'Samegrelo-Zemo Svaneti')
    SoldierTranslation.where(:place_from => 'მესტია').update_all(:region_from => 'სამეგრელი-ზემო სვანეთი')

    SoldierTranslation.where(:place_from => 'Mtskheta').update_all(:region_from => 'Mtskheta-Mtianeti')
    SoldierTranslation.where(:place_from => 'მცხეთა').update_all(:region_from => 'მცხეთა-მთიანეთი')

    SoldierTranslation.where(:place_from => 'Ozurgeti').update_all(:region_from => 'Guria')
    SoldierTranslation.where(:place_from => 'ოზურგეთი').update_all(:region_from => 'გურია')

    SoldierTranslation.where(:place_from => 'Qeda').update_all(:region_from => 'Adjara')
    SoldierTranslation.where(:place_from => 'ქედა').update_all(:region_from => 'აჭარა')

    SoldierTranslation.where(:place_from => 'Rustavi').update_all(:region_from => 'Kvemo Kartli')
    SoldierTranslation.where(:place_from => 'რუსთავი').update_all(:region_from => 'ქვემო ქართლი')

    SoldierTranslation.where(:place_from => 'Samtredia').update_all(:region_from => 'Imereti')
    SoldierTranslation.where(:place_from => 'სამტრედია').update_all(:region_from => 'იმერეთი')

    SoldierTranslation.where(:place_from => 'Senaki').update_all(:region_from => 'Samegrelo-Zemo Svaneti')
    SoldierTranslation.where(:place_from => 'სენაკი').update_all(:region_from => 'სამეგრელი-ზემო სვანეთი')

    SoldierTranslation.where(:place_from => 'Svaneti').update_all(:region_from => 'Samegrelo-Zemo Svaneti')
    SoldierTranslation.where(:place_from => 'სვანეთი').update_all(:region_from => 'სამეგრელი-ზემო სვანეთი')

    SoldierTranslation.where(:place_from => 'Tbilisi').update_all(:region_from => 'Tbilisi')
    SoldierTranslation.where(:place_from => 'თბილისი').update_all(:region_from => 'თბილისი')

    SoldierTranslation.where(:place_from => 'Tsalenjikha').update_all(:region_from => 'Samegrelo-Zemo Svaneti')
    SoldierTranslation.where(:place_from => 'წალენჯიხა').update_all(:region_from => 'სამეგრელი-ზემო სვანეთი')

    SoldierTranslation.where(:place_from => 'Vani').update_all(:region_from => 'Imereti')
    SoldierTranslation.where(:place_from => 'ვანი').update_all(:region_from => 'იმერეთი')

    SoldierTranslation.where(:place_from => 'Zugdidi').update_all(:region_from => 'Samegrelo-Zemo Svaneti')
    SoldierTranslation.where(:place_from => 'ზუგდიდი').update_all(:region_from => 'სამეგრელი-ზემო სვანეთი')
    
    # clear the cache files so the new data is avaialble
    JsonCache.clear

  end

  def down
    SoldierTranslation.update_all(:region_from => nil)

    # clear the cache files so the new data is avaialble
    JsonCache.clear
  end
end
