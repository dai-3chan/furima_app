# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

woman = Category.create(:name=>"レディース")

woman_tops = woman.children.create(:name=>"トップス")
woman_jacket = woman.children.create(:name=>"ジャケット/アウター")
woman_pants = woman.children.create(:name=>"パンツ")
woman_skirts = woman.children.create(:name=>"スカート")

woman_tops.children.create([{:name=>"Tシャツ/カットソー(半袖/袖なし)"},
                            {:name=>"Tシャツ/カットソー(七分/長袖)"},
                            {:name=>"シャツ/ブラウス(半袖/袖なし)"},
                            {:name=>"その他"}
                          ])
                            
woman_jacket.children.create([{:name=>"テーラードジャケット"},
                              {:name=>"ノーカラージャケット"}, 
                              {:name=>"Gジャン/デニムジャケット"},
                              {:name=>"その他"}
                            ])
woman_pants.children.create([{:name=>"デニム/ジーンズ"}, 
                             {:name=>"ショートパンツ"}, 
                             {:name=>"カジュアルパンツ"}, 
                             {:name=>"その他"}
                            ])
woman_skirts.children.create([{:name=>"ミニスカート"}, 
                            {:name=>"ひざ丈スカート"}, 
                            {:name=>"ロングスカート"}, 
                            {:name=>"その他"}
                            ])

man = Category.create(:name=>"メンズ")

man_tops = man.children.create(:name=>"トップス")
man_jacket = man.children.create(:name=>"ジャケット/アウター")
man_pants = man.children.create(:name=>"パンツ")
man_shoes = man.children.create(:name=>"靴")

man_tops.children.create([{:name=>"Tシャツ/カットソー(半袖/袖なし)"}, 
                          {:name=>"Tシャツ/カットソー(七分/長袖)"}, 
                          {:name=>"シャツ"}, 
                          {:name=>"その他"}
                        ])
man_jacket.children.create([{:name=>"テラードジャケット"}, 
                            {:name=>"ノーカラージャケット"}, 
                            {:name=>"Gジャン/デニムジャケット"}, 
                            {:name=>"その他"}
                          ])
man_pants.children.create([{:name=>"デニムジーンズ"}, 
                           {:name=>"ワークパンツ/カーゴパンツ"}, 
                           {:name=>"スラックス"}, 
                           {:name=>"その他"}
                          ])
man_shoes.children.create([{:name=>"スニーカー"}, 
                           {:name=>"サンダル"}, 
                           {:name=>"ブーツ"}, 
                           {:name=>"その他"}
                          ])

living = Category.create(:name=>"インテリア・住まい・小物")

living_kitchen = living.children.create(:name=>"キッチン/食器")
living_bed = living.children.create(:name=>"ベッド/マットレス")
living_sofa = living.children.create(:name=>"ソファ/ソファベッド")
living_chair = living.children.create(:name=>"椅子/チェア")

living_kitchen.children.create([{:name=>"食器"}, 
                                {:name=>"調理器具"}, 
                                {:name=>"収納"}, 
                                {:name=>"その他"}
                              ])
living_bed.children.create([{:name=>"セミシングルベッド"}, 
                            {:name=>"シングルベッド"}, 
                            {:name=>"セミダブルベッド"}, 
                            {:name=>"その他"}
                          ])
living_sofa.children.create([{:name=>"ソファセット"}, 
                            {:name=>"シングルソファ"}, 
                            {:name=>"ラブソファ"}, 
                            {:name=>"その他"}
                          ])
living_chair.children.create([{:name=>"一般"}, 
                              {:name=>"スツール"}, 
                              {:name=>"ダイニングチェア"}, 
                              {:name=>"その他"}
                            ])
             