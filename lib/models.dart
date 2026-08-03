import 'package:flutter/material.dart';
import 'dart:math';

// Base data structure
class Base {
  final int id;
  final String baseName;
  final int maxHealth;
  final Color color;

  const Base({
    required this.id,
    required this.baseName,
    required this.maxHealth,
    required this.color,
  });

  static Base? findById(int id) {
    return bases.firstWhere((base) => base.id == id, orElse: () => bases[0]);
  }
}

// Leader class for character images
class Leader {
  final int id;
  final String name;
  final String imagePath;

  const Leader({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  static Leader? findById(int id) {
    return leaders.firstWhere((leader) => leader.id == id, orElse: () => leaders[0]);
  }
}

// Damage tracker for handling accumulated damage
class DamageAccumulator {
  int _accumulatedDamage = 0;
  DateTime _lastDamageTime = DateTime.now();

  int addDamage(int damage) {
    final currentTime = DateTime.now();
    if (currentTime.difference(_lastDamageTime).inMilliseconds > 1000) {
      // Reset if more than 1 second has passed
      _accumulatedDamage = damage;
    } else {
      _accumulatedDamage += damage;
    }
    _lastDamageTime = currentTime;
    return _accumulatedDamage;
  }
}

// Random death message generator
String getRandomDeathMessage() {
  final deathMessages = [
    "Defeated.",
    "K.O.'d!",
    "Game Over",
    "Base Destroyed.",
    "Mission Failed.",
    "Oof.",
    "RIP.",
    ":("
  ];
  return deathMessages[Random().nextInt(deathMessages.length)];
}

// bases
final bases = [
  const Base(id: 1, baseName: "Chopper Base (Cunning)", maxHealth: 30, color: Colors.yellow),
  const Base(id: 2, baseName: "Administrator's Tower (Cunning)", maxHealth: 30, color: Colors.yellow),
  const Base(id: 3, baseName: "Jedha City (Cunning)", maxHealth: 25, color: Colors.yellow),
  const Base(id: 4, baseName: "Kestro City (Aggression)", maxHealth: 30, color: Colors.red),
  const Base(id: 5, baseName: "Catacombs of Cadera (Aggression)", maxHealth: 30, color: Colors.red),
  const Base(id: 6, baseName: "Tarkintown (Aggression)", maxHealth: 25, color: Colors.red),
  const Base(id: 7, baseName: "Echo Base (Command)", maxHealth: 30, color: Colors.green),
  const Base(id: 8, baseName: "Command Center (Command)", maxHealth: 30, color: Colors.green),
  const Base(id: 9, baseName: "Energy Conversion Lab (Command)", maxHealth: 25, color: Colors.green),
  const Base(id: 10, baseName: "Dagobah Swamp (Vigilance)", maxHealth: 30, color: Colors.blue),
  const Base(id: 11, baseName: "Capital City (Vigilance)", maxHealth: 30, color: Colors.blue),
  const Base(id: 12, baseName: "Security Complex (Vigilance)", maxHealth: 25, color: Colors.blue),
  const Base(id: 13, baseName: "Jabba's Palace (Cunning)", maxHealth: 30, color: Colors.yellow),
  const Base(id: 14, baseName: "Coronet City (Cunning)", maxHealth: 30, color: Colors.yellow),
  const Base(id: 15, baseName: "Spice Mines (Aggression)", maxHealth: 30, color: Colors.red),
  const Base(id: 16, baseName: "Death Watch Hideout (Aggression)", maxHealth: 30, color: Colors.red),
  const Base(id: 17, baseName: "Nevarro City (Command)", maxHealth: 30, color: Colors.green),
  const Base(id: 18, baseName: "Maz Kanata's Castle (Command)", maxHealth: 30, color: Colors.green),
  const Base(id: 19, baseName: "Remote Village (Vigilance)", maxHealth: 30, color: Colors.blue),
  const Base(id: 20, baseName: "Remnant Science Facility (Vigilance)", maxHealth: 30, color: Colors.blue),
  const Base(id: 21, baseName: "Pyke Palace (Cunning)", maxHealth: 30, color: Colors.yellow),
  const Base(id: 22, baseName: "Level 1313 (Cunning)", maxHealth: 30, color: Colors.yellow),
  const Base(id: 23, baseName: "Petranaki Arena (Cunning)", maxHealth: 26, color: Colors.yellow),
  const Base(id: 24, baseName: "The Nest (Aggression)", maxHealth: 30, color: Colors.red),
  const Base(id: 25, baseName: "KCM Mining Facility (Aggression)", maxHealth: 30, color: Colors.red),
  const Base(id: 26, baseName: "Shadow Collective Camp (Aggression)", maxHealth: 25, color: Colors.red),
  const Base(id: 27, baseName: "Tipoca City (Command)", maxHealth: 30, color: Colors.green),
  const Base(id: 28, baseName: "Lair of Grievous (Command)", maxHealth: 30, color: Colors.green),
  const Base(id: 29, baseName: "Droid Manufactory (Command)", maxHealth: 24, color: Colors.green),
  const Base(id: 30, baseName: "The Crystal City (Vigilance)", maxHealth: 30, color: Colors.blue),
  const Base(id: 31, baseName: "Sundari (Vigilance)", maxHealth: 30, color: Colors.blue),
  const Base(id: 32, baseName: "Pau City (Vigilance)", maxHealth: 26, color: Colors.blue),
  // Set 4
  const Base(id: 33, baseName: "Colossus (Vigilance)", maxHealth: 35, color: Colors.blue),
  const Base(id: 34, baseName: "Data Vault (Command)", maxHealth: 33, color: Colors.green),
  const Base(id: 35, baseName: "Thermal Oscillator (Aggression)", maxHealth: 27, color: Colors.red),
  const Base(id: 36, baseName: "Nabat Village (Cunning)", maxHealth: 27, color: Colors.yellow),
  const Base(id: 37, baseName: "Lake Country", maxHealth: 34, color: Colors.purple), // Unknown type, using purple
  const Base(id: 38, baseName: "City in the Clouds (Vigilance)", maxHealth: 30, color: Colors.blue),
  const Base(id: 39, baseName: "Shield Generator Complex (Vigilance)", maxHealth: 30, color: Colors.blue),
  const Base(id: 40, baseName: "Resistance Headquarters (Command)", maxHealth: 30, color: Colors.green),
  const Base(id: 41, baseName: "Theed Palace (Command)", maxHealth: 30, color: Colors.green),
  const Base(id: 42, baseName: "Massassi Temple (Aggression)", maxHealth: 30, color: Colors.red),
  const Base(id: 43, baseName: "Nadiri Dockyards (Aggression)", maxHealth: 30, color: Colors.red),
  const Base(id: 44, baseName: "Mos Eisley (Cunning)", maxHealth: 30, color: Colors.yellow),
  // Set 5
  const Base(id:45, baseName: "Vergence Temple(Vigilance)", maxHealth:25, color:Colors.blue),
  const Base(id:46, baseName: "Nightsister Lair(Vigilance)", maxHealth:28, color:Colors.blue),
  const Base(id:47, baseName: "Shadowed Undercity(Vigilance)", maxHealth:28, color:Colors.blue),
  const Base(id:48, baseName: "Mystic Monastery(Command)", maxHealth:25, color:Colors.green),
  const Base(id:49, baseName: "Jedi Temple(Command)", maxHealth:28, color:Colors.green),
  const Base(id:50, baseName: "Starlight Temple(Command)", maxHealth:28, color:Colors.green),
  const Base(id:51, baseName: "Temple of Destruction(Aggression)", maxHealth:25, color:Colors.red),
  const Base(id:52, baseName: "Fortress Vader(Aggression)", maxHealth:28, color:Colors.red),
  const Base(id:53, baseName: "Strangled Cliffs(Aggression)", maxHealth:28, color:Colors.red),
  const Base(id:54, baseName: "Tomb of Eilram(Cunning)", maxHealth:25, color:Colors.yellow),
  const Base(id:55, baseName: "Crystal Caves(Cunning)", maxHealth:28, color:Colors.yellow),
  const Base(id:56, baseName: "The Holy City(Cunning)", maxHealth:28, color:Colors.yellow),
  // Set 6
  const Base(id:57, baseName: "Rix Road(Vigilance)", maxHealth:30, color:Colors.blue),
  const Base(id:58, baseName: "Uscru Entertainment District(Vigilance)", maxHealth:30, color:Colors.blue),
  const Base(id:59, baseName: "Republic City(Command)", maxHealth:30, color:Colors.green),
  const Base(id:60, baseName: "Senate Rotunda(Command)", maxHealth:30, color:Colors.green),
  const Base(id:61, baseName: "Imperial Prison Complex(Aggression)", maxHealth:30, color:Colors.red),
  const Base(id:62, baseName: "Naval Intelligence HQ(Aggression)", maxHealth:30, color:Colors.red),
  const Base(id:63, baseName: "Amnesty Housing(Cunning)", maxHealth:30, color:Colors.yellow),
  const Base(id:64, baseName: "Mount Tantiss(Cunning)", maxHealth:30, color:Colors.yellow),
  // Set 7
  const Base(id:65, baseName:"Alliance Outpost(Vigilance)", maxHealth:26, color:Colors.blue),
  const Base(id:66, baseName:"Daimyo's Palace(Vigilance)", maxHealth:27, color:Colors.blue),
  const Base(id:67, baseName:"Coaxium Mine(Vigilance)", maxHealth:27, color:Colors.blue),
  const Base(id:68, baseName:"Aldhani Garrison(Command)", maxHealth:27, color:Colors.green),
  const Base(id:69, baseName:"Great Pit of Carkoon(Command)", maxHealth:27, color:Colors.green),
  const Base(id:70, baseName:"Imperial Command Complex(Command)", maxHealth:27, color:Colors.green),
  const Base(id:71, baseName:"Contested Caverns(Aggression)", maxHealth:27, color:Colors.red),
  const Base(id:72, baseName:"Shipbreaking Yard(Aggression)", maxHealth:26, color:Colors.red),
  const Base(id:73, baseName:"Stygeon Spire(Aggression)", maxHealth:27, color:Colors.red),
  const Base(id:74, baseName:"Canto Bight(Cunning)", maxHealth:27, color:Colors.yellow),
  const Base(id:75, baseName:"Citadel Research Center(Cunning)", maxHealth:26, color:Colors.yellow),
  const Base(id:74, baseName:"Partisan Hideout(Cunning)", maxHealth:27, color:Colors.yellow),
  // Set 8
  const Base(id:75, baseName:"Fortress of the Great Mothers(Vigilance)", maxHealth:30, color:Colors.blue),
  const Base(id:76, baseName:"Nevarro City, Restored(Vigilance)", maxHealth:30, color:Colors.blue),
  const Base(id:77, baseName:"Emperor's Throne Room(Command)", maxHealth:30, color:Colors.green),
  const Base(id:78, baseName:"Kryze Castle(Command)", maxHealth:30, color:Colors.green),
  const Base(id:79, baseName:"Ancient Henge(Aggression)", maxHealth:30, color:Colors.red),
  const Base(id:80, baseName:"Dragonsnake Bog(Aggression)", maxHealth:30, color:Colors.red),
  const Base(id:79, baseName:"Emperor's Observatory(Cunning)", maxHealth:30, color:Colors.yellow),
  const Base(id:79, baseName:"Freetown(Cunning)", maxHealth:30, color:Colors.yellow),
  







];

// leaders
final leaders = [
  const Leader(id: 1, name: "Yoda, Sensing Darkness", imagePath: "assets/images/leaders/yoda_sensing_darkness.webp"),
  const Leader(id: 2, name: "Captain Rex, Fighting for His Brothers", imagePath: "assets/images/leaders/captain_rex_fighting_for_his_brothers.webp"),
  const Leader(id: 3, name: "Darth Vader, Dark Lord of the Sith", imagePath: "assets/images/leaders/darth_vader_dark_lord_of_the_sith.webp"),
  const Leader(id: 4, name: "Luke Skywalker, Faithful Friend", imagePath: "assets/images/leaders/luke_skywalker_faithful_friend.webp"),
  const Leader(id: 5, name: "Han Solo, Audacious Smuggler", imagePath: "assets/images/leaders/han_solo_audacious_smuggler.webp"),
  const Leader(id: 6, name: "Obi-Wan Kenobi, Patient Mentor", imagePath: "assets/images/leaders/obi_wan_patient_mentor.webp"),
  const Leader(id: 7, name: "Emperor Palpatine, Galactic Ruler", imagePath: "assets/images/leaders/emperor_palpatine_galactic_ruler.webp"),
  const Leader(id: 8, name: "Ahsoka Tano, Snips", imagePath: "assets/images/leaders/ahsoka_tano_snips.webp"),
  const Leader(id: 9, name: "Boba Fett, Daimyo", imagePath: "assets/images/leaders/boba_fett_daimyo.webp"),
  const Leader(id: 10, name: "Maul, a Rival in Darkness", imagePath: "assets/images/leaders/maul_a_rival_in_darkness.webp"),
  const Leader(id: 11, name: "Cassian Andor, Dedicated to the Rebellion", imagePath: "assets/images/leaders/cassian_andor_dedicated_to_the_rebellion.webp"),
  const Leader(id: 12, name: "Jyn Erso, Resisting Oppression", imagePath: "assets/images/leaders/jyn_erso_resisting_oppression.webp"),
  const Leader(id: 13, name: "Sabine Wren, Galvanized Revolutionary", imagePath: "assets/images/leaders/sabine_wren_galvanized_revolutionary.webp"),
  const Leader(id: 14, name: "Boba Fett, Collecting the Bounty", imagePath: "assets/images/leaders/boba_fett_collecting_the_bounty.webp"),
  const Leader(id: 15, name: "IG-88, Ruthless Bounty Hunter", imagePath: "assets/images/leaders/ig_88_ruthless_bounty_hunter.webp"),
  const Leader(id: 16, name: "Grand Inquisitor, Hunting the Jedi", imagePath: "assets/images/leaders/grand_inquisitor_hunting_the_jedi.webp"),
  const Leader(id: 17, name: "Leia Organa, Alliance General", imagePath: "assets/images/leaders/leia_organa_alliance_general.webp"),
  const Leader(id: 18, name: "Hera Syndulla, Spectre Two", imagePath: "assets/images/leaders/hera_syndulla_spectre_two.webp"),
  const Leader(id: 19, name: "Grand Moff Tarkin, Oversector Governor", imagePath: "assets/images/leaders/grand_moff_tarkin_oversector_governor.webp"),
  const Leader(id: 20, name: "Chirrut Imwe, One with the Force", imagePath: "assets/images/leaders/chirrut_imwe_one_with_the_force.webp"),
  const Leader(id: 21, name: "Chewbacca, Walking Carpet", imagePath: "assets/images/leaders/chewbacca_walking_carpet.webp"),
  const Leader(id: 22, name: "Iden Versio, Inferno Squad Commander", imagePath: "assets/images/leaders/iden_versio_inferno_squad_commander.webp"),
  const Leader(id: 23, name: "Director Krennic, Aspiring to Authority", imagePath: "assets/images/leaders/director_krennic_aspiring_to_authority.webp"),
  const Leader(id: 24, name: "The Mandalorian, Sworn to the Creed", imagePath: "assets/images/leaders/the_mandalorian_sworn_to_the_creed.webp"),
  const Leader(id: 25, name: "Lando Calrissian, With Impeccable Taste", imagePath: "assets/images/leaders/lando_calrissian_with_impeccable_taste.webp"),
  const Leader(id: 26, name: "Fennec Shand, Honoring the Deal", imagePath: "assets/images/leaders/fennec_shand_honoring_the_deal.webp"),
  const Leader(id: 27, name: "Doctor Aphra, Rapacious Archaeologist", imagePath: "assets/images/leaders/doctor_aphra_rapacious_archaeologist.webp"),
  const Leader(id: 28, name: "Cad Bane, He Who Needs No Introduction", imagePath: "assets/images/leaders/cad_bane_he_who_needs_no_introduction.webp"),
  const Leader(id: 29, name: "Han Solo, Worth the Risk", imagePath: "assets/images/leaders/han_solo_worth_the_risk.webp"),
  const Leader(id: 30, name: "Bo Katan Kryze, Princess in Exile", imagePath: "assets/images/leaders/bo_katan_kryze_princess_in_exile.webp"),
  const Leader(id: 31, name: "Kylo Ren, Rash and Deadly", imagePath: "assets/images/leaders/kylo_ren_rash_and_deadly.webp"),
  const Leader(id: 32, name: "Bossk, Hunting His Prey", imagePath: "assets/images/leaders/bossk_hunting_his_prey.webp"),
  const Leader(id: 33, name: "Hunter, Outcast Sergeant", imagePath: "assets/images/leaders/hunter_outcast_sergeant.webp"),
  const Leader(id: 34, name: "Moff Gideon, Formidable Commander", imagePath: "assets/images/leaders/moff_gideon_formidable_commander.webp"),
  const Leader(id: 35, name: "Jabba the Hutt, His High Exaltedness", imagePath: "assets/images/leaders/jabba_the_hutt_his_high_exaltedness.webp"),
  const Leader(id: 36, name: "Hondo Ohnaka, That's Good Business", imagePath: "assets/images/leaders/hondo_ohnaka_thats_good_business.webp"),
  const Leader(id: 37, name: "Rey, More Than a Scavenger", imagePath: "assets/images/leaders/rey_more_than_a_scavenger.webp"),
  const Leader(id: 38, name: "Finn, This is a Rescue", imagePath: "assets/images/leaders/finn_this_is_a_rescue.webp"),
  const Leader(id: 39, name: "Qira, I Alone Survived", imagePath: "assets/images/leaders/qira_i_alone_survived.webp"),
  const Leader(id: 40, name: "Gar Saxon, Viceroy of Mandalore", imagePath: "assets/images/leaders/gar_saxon_viceroy_of_mandalore.webp"),
  const Leader(id: 41, name: "Quinlan Vos, Sticking the Landing", imagePath: "assets/images/leaders/quinlan_vos_sticking_the_landing.webp"),
  const Leader(id: 42, name: "Chancellor Palpatine, Playing Both Sides", imagePath: "assets/images/leaders/chancellor_palpatine_playing_both_sides.webp"),
  const Leader(id: 43, name: "Jango Fett, Concealing the Conspiracy", imagePath: "assets/images/leaders/jango_fett_concealing_the_conspiracy.webp"),
  const Leader(id: 44, name: "General Grievous, General of the Droid Armies", imagePath: "assets/images/leaders/general_grievous_general_of_the_droid_armies.webp"),
  const Leader(id: 45, name: "Asajj Ventress, Unparalleled Adversary", imagePath: "assets/images/leaders/asajj_ventress_unparalleled_adversary.webp"),
  const Leader(id: 46, name: "Mace Windu, Vaapad Form Master", imagePath: "assets/images/leaders/mace_windu_vaapad_form_master.webp"),
  const Leader(id: 47, name: "Anakin Skywalker, What It Takes to Win", imagePath: "assets/images/leaders/anakin_skywalker_what_it_takes_to_win.webp"),
  const Leader(id: 48, name: "Pre Vizsla, Pursuing the Throne", imagePath: "assets/images/leaders/pre_vizsla_pursuing_the_throne.webp"),
  const Leader(id: 49, name: "Padme Amidala, Serving the Republic", imagePath: "assets/images/leaders/padme_amidala_serving_the_republic.webp"),
  const Leader(id: 50, name: "Wat Tambor, Techno Union Foreman", imagePath: "assets/images/leaders/wat_tambor_techno_union_foreman.webp"),
  const Leader(id: 51, name: "Count Dooku, Face of the Confederacy", imagePath: "assets/images/leaders/count_dooku_face_of_the_confederacy.webp"),
  const Leader(id: 52, name: "Nute Gunray, Vindictive Viceroy", imagePath: "assets/images/leaders/nute_gunray_vindictive_viceroy.webp"),
  const Leader(id: 53, name: "Nala Se, Clone Engineer", imagePath: "assets/images/leaders/nala_se_clone_engineer.webp"),

  // Jump to Lightspeed leaders
  const Leader(id: 54, name: "Asajj Ventress, I Work Alone", imagePath: "assets/images/leaders/asajj_ventress_i_work_alone.jpg"),
  const Leader(id: 55, name: "Grand Admiral Thrawn, How Unfortunate", imagePath: "assets/images/leaders/grand_admiral_thrawn_how_unfortunate.jpg"),
  const Leader(id: 56, name: "Rose Tico, Saving What We Love", imagePath: "assets/images/leaders/rose_tico_saving_what_we_love.jpg"),
  const Leader(id: 57, name: "Lando Calrissian, Buying Time", imagePath: "assets/images/leaders/lando_calrissian_buying_time.jpg"),
  const Leader(id: 58, name: "Admiral Piett, Commanding the Armada", imagePath: "assets/images/leaders/admiral_piett_commanding_the_armada.jpg"),
  const Leader(id: 59, name: "Admiral Holdo, We're Not Alone", imagePath: "assets/images/leaders/admiral_holdo_were_not_alone.jpg"),
  const Leader(id: 60, name: "Wedge Antilles, Leader of Red Squadron", imagePath: "assets/images/leaders/wedge_antilles_leader_of_red_sqaudron.jpg"),
  const Leader(id: 61, name: "Darth Vader, Victor Squadron Leader", imagePath: "assets/images/leaders/darth_vader_victor_squadron_leader.webp"),
  const Leader(id: 62, name: "Boba Fett, Any Methods Necessary", imagePath: "assets/images/leaders/boba_fett_any_methods_necessary.jpg"),
  const Leader(id: 63, name: "Poe Dameron, I Can Fly Anything", imagePath: "assets/images/leaders/poe_dameron_i_can_fly_anything.jpg"),
  const Leader(id: 64, name: "Luke Skywalker, Hero of Yavin", imagePath: "assets/images/leaders/luke_skywalker_hero_of_yavin.jpg"),
  const Leader(id: 65, name: "Major Vonreg, Red Baron", imagePath: "assets/images/leaders/major_vonreg_red_baron.webp"),
  const Leader(id: 66, name: "Captain Phasma, Chrome Dome", imagePath: "assets/images/leaders/captain_phasma_chrome_dome.jpg"),
  const Leader(id: 67, name: "Admiral Trench, Chk-Chk-Chk-Chk", imagePath: "assets/images/leaders/admiral_trench_chk_chk_chk_chk.jpg"),
  const Leader(id: 68, name: "Rio Durant, Wisecracking Wheelman", imagePath: "assets/images/leaders/rio_durant_wisecracking_wheelman.jpg"),
  const Leader(id: 69, name: "Admiral Ackbar, It's a Trap!", imagePath: "assets/images/leaders/admiral_ackbar_its_a_trap.jpg"),
  const Leader(id: 70, name: "Han Solo, Never Tell Me the Odds", imagePath: "assets/images/leaders/han_solo_never_tell_me_the_odds.jpg"),
  const Leader(id: 71, name: "Kazuda Xiono, Best Pilot in the Galaxy", imagePath: "assets/images/leaders/kazuda_xiono_best_pilot_in_the_galaxy.jpg"),

  // Legends of the Force Leaders
  const Leader(id: 72, name: "Third Sister, Seething With Ambition", imagePath: "assets/images/leaders/third_sister_seething_with_ambition.webp"),
  const Leader(id: 73, name: "Qui-Gon Jinn, Student of the Living Force", imagePath: "assets/images/leaders/qui_gon_jinn_student_of_the_living_force.webp"),
  const Leader(id: 74, name: "Darth Revan, Scourge of the Old Republic", imagePath: "assets/images/leaders/darth_revan_scourge_of_the_old_republic.webp"),
  const Leader(id: 75, name: "Kanan Jarrus, Help Us Survive", imagePath: "assets/images/leaders/kanan_jarrus_help_us_survive.jpg"),
  const Leader(id: 76, name: "Obi-Wan Kenobi, Courage Makes Heroes", imagePath: "assets/images/leaders/obi_wan_kenobi_courage_makes_heroes.webp"),
  const Leader(id: 77, name: "Darth Maul, Sith Revealed", imagePath: "assets/images/leaders/darth_maul_sith_revealed.webp"),
  const Leader(id: 78, name: "Anakin Skywalker, Tempted by the Dark Side", imagePath: "assets/images/leaders/anakin_skywalker_tempted_by_the_dark_side.webp"),
  const Leader(id: 79, name: "Cal Kestis, I Can't Keep Hiding", imagePath: "assets/images/leaders/cal_kestis_i_cant_keep_hiding.webp"),
  const Leader(id: 80, name: "Barriss Offee, We Have Become Villians", imagePath: "assets/images/leaders/barriss_offee_we_have_become_villians.webp"),
  const Leader(id: 81, name: "Rey, Nobody", imagePath: "assets/images/leaders/rey_nobody.webp"),
  const Leader(id: 82, name: "Kit Fisto, Focused Jedi Master", imagePath: "assets/images/leaders/kit_fisto_focused_jedi_master.webp"),
  const Leader(id: 83, name: "Avar Kriss, Marshal of Starlight", imagePath: "assets/images/leaders/avar_kiss_marshal_of_starlight.webp"),
  const Leader(id: 84, name: "Supreme Leader Snoke, In the Seat of Power", imagePath: "assets/images/leaders/supreme_leader_snoke_in_the_seat_of_power.webp"),
  const Leader(id: 85, name: "Morgan Elsbeth, Following the Call", imagePath: "assets/images/leaders/morgan_elsbeth_following_the_call.webp"),
  const Leader(id: 86, name: "Ahsoka Tano, Fighting for Peace", imagePath: "assets/images/leaders/ahsoka_tano_fighting_for_peace.webp"),
  const Leader(id: 87, name: "Mother Talzin, Power Through Magick", imagePath: "assets/images/leaders/mother_talzin_power_through_magic.webp"),
  const Leader(id: 88, name: "Kylo Ren, We're Not Done Yet", imagePath: "assets/images/leaders/kylo_ren_were_not_done_yet.webp"),

  // Set 6 Leaders
  const Leader(id: 89, name: "Chancellor Palpatine, How Liberty Dies", imagePath: "assets/images/leaders/chancellor_palpatine_how_liberty_dies.webp"),
  const Leader(id: 90, name: "Jabba the Hutt, Wonderful Human Being", imagePath: "assets/images/leaders/jabba_the_hutt_wonderful_human_being.webp"),
  const Leader(id: 91, name: "Lama Su, We Modified Their Genetics", imagePath: "assets/images/leaders/lama_su_we_modified_their_genetics.webp"),
  const Leader(id: 92, name: "Leia Organa, Of a Secret Bloodline", imagePath: "assets/images/leaders/leia_organa_of_a_secret_bloodline.webp"),
  const Leader(id: 93, name: "Satine Kryze, Standing on Principles", imagePath: "assets/images/leaders/satine_kryze_standing_on_principles.webp"),
  const Leader(id: 94, name: "Colonel Yularen, This is Why We Plan", imagePath: "assets/images/leaders/colonel_yularen_this_is_why_we_plan.webp"),
  const Leader(id: 95, name: "Dryden Vos, I Never Ask Twice", imagePath: "assets/images/leaders/dryden_vos_i_never_ask_twice.webp"),
  const Leader(id: 96, name: "Bail Organa, Doing Everything He Can", imagePath: "assets/images/leaders/bail_organa_doing_everything_he_can.webp"),
  const Leader(id: 97, name: "Mon Mothma, Forming a Coalition", imagePath: "assets/images/leaders/mon_mothma_forming_a_coalition.webp"),
  const Leader(id: 98, name: "Dedra Meero, Not Wasting Time", imagePath: "assets/images/leaders/dedra_meero_not_wasting_time.webp"),
  const Leader(id: 99, name: "Governor Pryce, Tyrant of Lothal", imagePath: "assets/images/leaders/governor_pryce_tyrant_of_lothal.webp"),
  const Leader(id: 100, name: "Cassian Andor, Climb!", imagePath: "assets/images/leaders/cassian_andor_climb.webp"),
  const Leader(id: 101, name: "Luthen Rael, Don't You Want to Fight For Real?", imagePath: "assets/images/leaders/luthen_rael_dont_you_want_to_fight_for_real.webp"),
  const Leader(id: 102, name: "Sly Moore, Cipher in the Dark", imagePath: "assets/images/leaders/sly_moore_cipher_in_the_dark.webp"),
  const Leader(id: 103, name: "C-3PO, Human-Cyborg Relations", imagePath: "assets/images/leaders/c3po_human_cyborg_relations.webp"),
  const Leader(id: 104, name: "Padme Amidala, What Do You Have to Hide?", imagePath: "assets/images/leaders/padme_amidala_what_do_you_have_to_hide.webp"),
  const Leader(id: 105, name: "Sabe, Queen's Shadow", imagePath: "assets/images/leaders/sabe_queens_shadow.webp"),
  const Leader(id: 106, name: "DJ, Need a Lift?", imagePath: "assets/images/leaders/dj_need_a_lift.webp"),

  // Showcase images
  const Leader(id: 200, name: "Yoda, Sensing Darkness (Showcase)", imagePath: "assets/images/leaders/yoda_sensing_darkness_showcase.webp"),
  const Leader(id: 201, name: "Captain Rex, Fighting for His Brothers (Showcase)", imagePath: "assets/images/leaders/captain_rex_fighting_for_his_brothers_showcase.webp"),
  const Leader(id: 202, name: "Darth Vader, Dark Lord of the Sith (Showcase Prize Wall)", imagePath: "assets/images/leaders/darth_vader_dark_lord_of_the_sith_prize_wall.webp"),
  const Leader(id: 203, name: "Luke Skywalker, Faithful Friend (Showcase Prize Wall)", imagePath: "assets/images/leaders/luke_skywalker_faithful_friend_prize_wall.webp"),
  const Leader(id: 204, name: "Han Solo, Audacious Smuggler (Showcase)", imagePath: "assets/images/leaders/han_solo_audacious_smuggler_showcase.webp"),
  const Leader(id: 205, name: "Obi-Wan Kenobi, Patient Mentor (Showcase)", imagePath: "assets/images/leaders/obi_wan_kenobi_patient_mentor_showcase.webp"),
  const Leader(id: 206, name: "Emperor Palpatine, Galactic Ruler (Showcase)", imagePath: "assets/images/leaders/emperor_palpatine_galactic_ruler_showcase.webp"),
  const Leader(id: 207, name: "Ahsoka Tano, Snips (Showcase)", imagePath: "assets/images/leaders/ahsoka_tano_snips_showcase.webp"),
  const Leader(id: 208, name: "Boba Fett, Daimyo (Showcase)", imagePath: "assets/images/leaders/boba_fett_daimyo_showcase.webp"),
  const Leader(id: 209, name: "Maul, a Rival in Darkness (Showcase)", imagePath: "assets/images/leaders/maul_a_rival_in_darkness_showcase.webp"),
  const Leader(id: 210, name: "Cassian Andor, Dedicated to the Rebellion (Showcase)", imagePath: "assets/images/leaders/cassian_andor_dedicated_to_the_rebellion_showcase.webp"),
  const Leader(id: 211, name: "Jyn Erso, Resisting Oppression (Showcase)", imagePath: "assets/images/leaders/jyn_erso_resisting_oppression_showcase.webp"),
  const Leader(id: 212, name: "Sabine Wren, Galvanized Revolutionary (Showcase)", imagePath: "assets/images/leaders/sabine_wren_galvanized_revolutionary_showcase.webp"),
  const Leader(id: 213, name: "Boba Fett, Collecting the Bounty (Showcase)", imagePath: "assets/images/leaders/boba_fett_collecting_the_bounty_showcase.webp"),
  const Leader(id: 214, name: "IG-88, Ruthless Bounty Hunter (Showcase)", imagePath: "assets/images/leaders/ig_88_ruthless_bounty_hunter_showcase.webp"),
  const Leader(id: 215, name: "Grand Inquisitor, Hunting the Jedi (Showcase)", imagePath: "assets/images/leaders/grand_inquisitor_hunting_the_jedi_showcase.webp"),
  const Leader(id: 216, name: "Leia Organa, Alliance General (Showcase)", imagePath: "assets/images/leaders/leia_organa_alliance_general_showcase.webp"),
  const Leader(id: 217, name: "Hera Syndulla, Spectre Two (Showcase)", imagePath: "assets/images/leaders/hera_syndulla_spectre_two_showcase.webp"),
  const Leader(id: 218, name: "Grand Moff Tarkin, Oversector Governor (Showcase)", imagePath: "assets/images/leaders/grand_moff_tarkin_oversector_governor_showcase.webp"),
  const Leader(id: 219, name: "Chirrut Imwe, One with the Force (Showcase)", imagePath: "assets/images/leaders/chirrut_imwe_one_with_the_force_showcase.webp"),
  const Leader(id: 220, name: "Chewbacca, Walking Carpet (Showcase)", imagePath: "assets/images/leaders/chewbacca_walking_carpet_showcase.webp"),
  const Leader(id: 221, name: "Iden Versio, Inferno Squad Commander (Showcase)", imagePath: "assets/images/leaders/iden_versio_inferno_squad_commander_showcase.webp"),
  const Leader(id: 222, name: "Director Krennic, Aspiring to Authority (Showcase)", imagePath: "assets/images/leaders/director_krennic_aspiring_to_authority_showcase.webp"),
  const Leader(id: 223, name: "The Mandalorian, Sworn to the Creed (Showcase)", imagePath: "assets/images/leaders/the_mandalorian_sworn_to_the_creed_showcase.webp"),
  const Leader(id: 224, name: "Lando Calrissian, With Impeccable Taste (Showcase)", imagePath: "assets/images/leaders/lando_calrissian_with_impeccable_taste_showcase.webp"),
  const Leader(id: 225, name: "Fennec Shand, Honoring the Deal (Showcase)", imagePath: "assets/images/leaders/fennec_shand_honoring_the_deal_showcase.webp"),
  const Leader(id: 226, name: "Doctor Aphra, Rapacious Archaeologist (Showcase)", imagePath: "assets/images/leaders/doctor_aphra_rapacious_archaeologist_showcase.webp"),
  const Leader(id: 227, name: "Cad Bane, He Who Needs No Introduction (Showcase)", imagePath: "assets/images/leaders/cad_bane_he_who_needs_no_introduction_showcase.webp"),
  const Leader(id: 228, name: "Han Solo, Worth the Risk (Showcase)", imagePath: "assets/images/leaders/han_solo_worth_the_risk_showcase.webp"),
  const Leader(id: 229, name: "Bo Katan Kryze, Princess in Exile (Showcase)", imagePath: "assets/images/leaders/bo_katan_kryze_princess_in_exile_showcase.webp"),
  const Leader(id: 230, name: "Kylo Ren, Rash and Deadly (Showcase)", imagePath: "assets/images/leaders/kylo_ren_rash_and_deadly_showcase.webp"),
  const Leader(id: 231, name: "Bossk, Hunting His Prey (Showcase)", imagePath: "assets/images/leaders/bossk_hunting_his_prey_showcase.webp"),
  const Leader(id: 232, name: "Hunter, Outcast Sergeant (Showcase)", imagePath: "assets/images/leaders/hunter_outcast_sergeant_showcase.webp"),
  const Leader(id: 233, name: "Moff Gideon, Formidable Commander (Showcase)", imagePath: "assets/images/leaders/moff_gideon_formidable_commander_showcase.webp"),
  const Leader(id: 234, name: "Jabba the Hutt, His High Exaltedness (Showcase)", imagePath: "assets/images/leaders/jabba_the_hutt_his_high_exaltedness_showcase.webp"),
  const Leader(id: 235, name: "Hondo Ohnaka, That's Good Business (Showcase)", imagePath: "assets/images/leaders/hondo_ohnaka_thats_good_business_showcase.webp"),
  const Leader(id: 236, name: "Rey, More Than a Scavenger (Showcase)", imagePath: "assets/images/leaders/rey_more_than_a_scavenger_showcase.webp"),
  const Leader(id: 237, name: "Finn, This is a Rescue (Showcase)", imagePath: "assets/images/leaders/finn_this_is_a_rescue_showcase.webp"),
  const Leader(id: 238, name: "Qira, I Alone Survived (Showcase)", imagePath: "assets/images/leaders/qira_i_alone_survived_showcase.webp"),
  const Leader(id: 239, name: "Gar Saxon, Viceroy of Mandalore (Showcase)", imagePath: "assets/images/leaders/gar_saxon_viceroy_of_mandalore_showcase.webp"),
  const Leader(id: 240, name: "Quinlan Vos, Sticking the Landing (Showcase)", imagePath: "assets/images/leaders/quinlan_vos_sticking_the_landing_showcase.webp"),
  const Leader(id: 241, name: "Chancellor Palpatine, Playing Both Sides (Showcase)", imagePath: "assets/images/leaders/chancellor_palpatine_playing_both_sides_showcase.webp"),
  const Leader(id: 242, name: "Jango Fett, Concealing the Conspiracy (Showcase)", imagePath: "assets/images/leaders/jango_fett_concealing_the_conspiracy_showcase.webp"),
  const Leader(id: 243, name: "General Grievous, General of the Droid Armies (Showcase)", imagePath: "assets/images/leaders/general_grievous_general_of_the_droid_armies_showcase.webp"),
  const Leader(id: 244, name: "Asajj Ventress, Unparalleled Adversary (Showcase)", imagePath: "assets/images/leaders/asajj_ventress_unparalleled_adversary_showcase.webp"),
  const Leader(id: 245, name: "Mace Windu, Vaapad Form Master (Showcase)", imagePath: "assets/images/leaders/mace_windu_vaapad_form_master_showcase.webp"),
  const Leader(id: 246, name: "Anakin Skywalker, What It Takes to Win (Showcase)", imagePath: "assets/images/leaders/anakin_skywalker_what_it_takes_to_win_showcase.webp"),
  const Leader(id: 247, name: "Pre Vizsla, Pursuing the Throne (Showcase)", imagePath: "assets/images/leaders/pre_vizsla_pursuing_the_throne_showcase.webp"),
  const Leader(id: 248, name: "Padme Amidala, Serving the Republic (Showcase)", imagePath: "assets/images/leaders/padme_amidala_serving_the_republic_showcase.webp"),
  const Leader(id: 249, name: "Wat Tambor, Techno Union Foreman (Showcase)", imagePath: "assets/images/leaders/wat_tambor_techno_union_foreman_showcase.webp"),
  const Leader(id: 250, name: "Count Dooku, Face of the Confederacy (Showcase)", imagePath: "assets/images/leaders/count_dooku_face_of_the_confederacy_showcase.webp"),
  const Leader(id: 251, name: "Nute Gunray, Vindictive Viceroy (Showcase)", imagePath: "assets/images/leaders/nute_gunray_vindictive_viceroy_showcase.webp"),
  const Leader(id: 252, name: "Nala Se, Clone Engineer (Showcase)", imagePath: "assets/images/leaders/nala_se_clone_engineer_showcase.webp"),

  // Set 4 Showcases
  const Leader(id: 253, name: "Asajj Ventress, I Work Alone (Showcase)", imagePath: "assets/images/leaders/asajj_ventress_i_work_alone_showcase.webp"),
  const Leader(id: 254, name: "Grand Admiral Thrawn, ...How Unfortunate (Showcase)", imagePath: "assets/images/leaders/grand_admiral_thrawn_how_unfortunate_showcase.webp"),
  const Leader(id: 255, name: "Lando Calrissian, Buying Time (Showcase)", imagePath: "assets/images/leaders/lando_calrissian_buying_time_showcase.webp"),
  const Leader(id: 256, name: "Rose Tico, Saving What We Love (Showcase)", imagePath: "assets/images/leaders/rose_tico_saving_what_we_love_showcase.webp"),
  const Leader(id: 257, name: "Admiral Piett, Commanding the Armada (Showcase)", imagePath: "assets/images/leaders/admiral_piett_commanding_the_armada_showcase.webp"),
  const Leader(id: 258, name: "Admiral Holdo, We're Not Alone (Showcase)", imagePath: "assets/images/leaders/admiral_holdo_were_not_alone_showcase.webp"),
  const Leader(id: 259, name: "Wedge Antilles, Leader of Red Squadron (Showcase)", imagePath: "assets/images/leaders/wedge_antilles_leader_of_red_squadron_showcase.webp"),
  const Leader(id: 260, name: "Boba Fett, Any Methods Necessary (Showcase)", imagePath: "assets/images/leaders/boba_fett_any_methods_necessary_showcase.webp"),
  const Leader(id: 261, name: "Captain Phasma, Chrome Dome (Showcase)", imagePath: "assets/images/leaders/captain_phasma_chrome_dome_showcase.webp"),
  const Leader(id: 262, name: "Luke Skywalker, Hero of Yavin (Showcase)", imagePath: "assets/images/leaders/luke_skywalker_hero_of_yavin_showcase.webp"),
  const Leader(id: 263, name: "Poe Dameron, I Can Fly Anything (Showcase)", imagePath: "assets/images/leaders/poe_dameron_i_can_fly_anything_showcase.webp"),
  const Leader(id: 264, name: "Admiral Trench, Chk Chk Chk Chk (Showcase)", imagePath: "assets/images/leaders/admiral_trench_chk_chk_chk_chk_showcase.webp"),
  const Leader(id: 265, name: "Rio Durant, Wisecracking Wheelman (Showcase)", imagePath: "assets/images/leaders/rio_durant_wisecracking_wheelman_showcase.webp"),
  const Leader(id: 266, name: "Admiral Ackbar, It's a Trap! (Showcase)", imagePath: "assets/images/leaders/admiral_ackbar_its_a_trap_showcase.webp"),
  const Leader(id: 267, name: "Han Solo, Never Tell Me The Odds (Showcase)", imagePath: "assets/images/leaders/han_solo_never_tell_me_the_odds_showcase.webp"),
  const Leader(id: 268, name: "Kazuda Xiono, Best Pilot in the Galaxy (Showcase)", imagePath: "assets/images/leaders/kazuda_xiono_best_pilot_in_the_galaxy_showcase.webp"),
  const Leader(id: 269, name: "Major Vonreg, Red Baron (Showcase)", imagePath: "assets/images/leaders/major_vonreg_red_baron_showcase.jpg"),

  // LOF Showcases
  const Leader(id: 270, name: "Kylo Ren, We're Not Done Yet (Showcase)", imagePath: "assets/images/leaders/kylo_ren_were_not_done_yet_showcase.webp"),
  const Leader(id: 271, name: "Mother Talzin, Power Through Magick (Showcase)", imagePath: "assets/images/leaders/mother_talzin_power_through_magick_showcase.webp"),
  const Leader(id: 272, name: "Ahsoka Tano, Fighting for Peace (Showcase)", imagePath: "assets/images/leaders/ahsoka_tano_fighting_for_peace_showcase.webp"),
  const Leader(id: 273, name: "Morgan Elsbeth, Following the Call (Showcase)", imagePath: "assets/images/leaders/morgan_elsbeth_following_the_call_showcase.webp"),
  const Leader(id: 274, name: "Supreme Leader Snoke, In the Seat of Power (Showcase)", imagePath: "assets/images/leaders/supreme_leader_snoke_in_the_seat_of_power_showcase.webp"),
  const Leader(id: 275, name: "Avar Kriss, Marshall of Starlight (Showcase)", imagePath: "assets/images/leaders/avar_kriss_marshal_of_starlight_showcase.webp"),
  const Leader(id: 276, name: "Kit Fisto, Focused Jedi Master (Showcase)", imagePath: "assets/images/leaders/kit_fisto_focused_jedi_master_showcase.webp"),
  const Leader(id: 277, name: "Rey, Nobody (Showcase)", imagePath: "assets/images/leaders/rey_nobody_showcase.webp"),
  const Leader(id: 278, name: "Barriss Offee, We Have Become Villians (Showcase)", imagePath: "assets/images/leaders/barris_ofee_we_have_become_villians_showcase.webp"),
  const Leader(id: 279, name: "Cal Kestis, I Can't Keep Hiding (Showcase)", imagePath: "assets/images/leaders/cal_kestis_i_cant_keep_hiding_showcase.webp"),
  const Leader(id: 280, name: "Anakin Skywalker, Tempted by the Dark Side (Showcase)", imagePath: "assets/images/leaders/anakin_skywalke_tempted_by_the_dark_side_showcase.webp"),
  const Leader(id: 281, name: "Darth Maul, Sith Revealed (Showcase)", imagePath: "assets/images/leaders/darth_maul_sith_revealed_showcase.webp"),
  const Leader(id: 282, name: "Obi-Wan Kenobi, Courage Makes Heroes (Showcase)", imagePath: "assets/images/leaders/obi_wan_kenobi_courage_makes_heroes_showcase.webp"),
  const Leader(id: 283, name: "Kanan Jarrus, Help Us Survive (Showcase)", imagePath: "assets/images/leaders/kanan_jarrus_help_us_survive_showcase.webp"),
  const Leader(id: 284, name: "Darth Revan, Scourge of the Old Republic (Showcase)", imagePath: "assets/images/leaders/darth_revan_scourge_of_the_old_republic_showcase.webp"),
  const Leader(id: 285, name: "Qui Gon Jinn, Student of the Living Force (Showcase)", imagePath: "assets/images/leaders/qui_gon_jinn_student_of_the_living_force_showcase.webp"),
  const Leader(id: 286, name: "Third Sister, Seething with Ambition (Showcase)", imagePath: "assets/images/leaders/third_sister_seething_with_ambition_showcase.webp"),

  // SEC showcases
  const Leader(id:287, name: "Chancellor Palpatine, How Liberty Dies (Showcase)", imagePath: "assets/images/leaders/chancellor_palpatine_how_liberty_dies_showcase.webp"),
  const Leader(id:288, name: "Jabba the Hutt, Wonderful Human Being (Showcase)", imagePath: "assets/images/leaders/jabba_the_hutt_wonderful_human_being_showcase.webp"),
  const Leader(id:289, name:"Lama Su, We Modified Their Genetics (Showcase)", imagePath: "assets/images/leaders/lama_su_we_modified_their_genetics_showcase.webp"),
  const Leader(id:290, name:"Leia Organa, Of a Secret Bloodline (Showcase)", imagePath: "assets/images/leaders/leia_organa_of_a_secret_bloodline_showcase.webp"),
  const Leader(id:291, name:"Satine Kryze, Standing on Principles (Showcase)", imagePath: "assets/images/leaders/satine_kryze_standing_on_principles_showcase.webp"),
  const Leader(id:292, name:"Colonel Yularen, This is Why We Plan (Showcase)", imagePath: "assets/images/leaders/colonel_yularen_this_is_why_we_plan_showcase.webp"),
  const Leader(id:293, name:"Dryden Vos, I Never Ask Twice (Showcase)", imagePath: "assets/images/leaders/dryden_vos_i_never_ask_twice_showcase.webp"),
  const Leader(id:294, name:"Bail Organa, Doing Everything He Can (Showcase)", imagePath: "assets/images/leaders/bail_organa_doing_everything_he_can_showcase.webp"),
  const Leader(id:295, name:"Mon Mothma, Forming a Coalition (Showcase)", imagePath: "assets/images/leaders/mon_mothma_forming_a_coalition_showcase.webp"),
  const Leader(id:296, name:"Dedra Meero, Not Wasting Time (Showcase)", imagePath: "assets/images/leaders/dedra_meero_not_wasting_time_showcase.webp"),
  const Leader(id:297, name:"Governor Pryce, Tyrant of Lothal (Showcase)", imagePath: "assets/images/leaders/governor_pryce_tyrant_of_lothal_showcase.webp"),
  const Leader(id:298, name:"Cassian Andor, Climb! (Showcase)", imagePath: "assets/images/leaders/cassian_andor_climb_showcase.webp"),
  const Leader(id:299, name:"Luthen Rael, Don't You Want to Fight For Real? (Showcase)", imagePath: "assets/images/leaders/luthen_rael_dont_you_want_to_fight_for_real_showcase.webp"),
  const Leader(id:300, name:"Sly Moore, Cipher in the Dark (Showcase)", imagePath: "assets/images/leaders/sly_moore_cipher_in_the_dark_showcase.webp"),
  const Leader(id:301, name:"C-3PO, Human-Cyborg Relations (Showcase)", imagePath: "assets/images/leaders/c-3po_human_cyborg_relations_showcase.webp"),
  const Leader(id:302, name:"Padme Amidala, What do You Have to Hide? (Showcase)", imagePath: "assets/images/leaders/padme_amidala_what_do_you_have_to_hide_showcase.webp"),
  const Leader(id:303, name:"Sabe, Queen's Shadow (Showcase)", imagePath: "assets/images/leaders/sabe_queens_shadow_showcase.webp"),
  const Leader(id:304, name:"DJ, Need a Lift? (Showcase)", imagePath: "assets/images/leaders/dj_need_a_lift_showcase.webp"),

  // LAW Leaders
  const Leader(id:305, name:"Saw Gerrara, Bring Down the Empire", imagePath: "assets/images/leaders/saw_gerrara_bring_down_the_empire.png"),
  const Leader(id:306, name:"Tobias Beckett, People Are Predictable", imagePath: "assets/images/leaders/tobias_beckett_people_are_predictable.png"),
  const Leader(id:306, name:"Agent Kallus, Reconsider Your Allegiance", imagePath: "assets/images/leaders/agent_kallus_reconsider_your_allegiance.png"),
  const Leader(id:307, name:"Aurra Sing, Assassin", imagePath: "assets/images/leaders/aurra_sing_assassin.png"),
  const Leader(id:308, name:"Jyn Erso, Time to Fight", imagePath: "assets/images/leaders/jyn_erso_time_to_fight.png"),
  const Leader(id:309, name:"Vel Sartha, Aldhani Insurgent", imagePath: "assets/images/leaders/vel_sartha_aldhani_insurgent.png"),
  const Leader(id:310, name:"Boba Fett, Krayt's Claw Commander", imagePath: "assets/images/leaders/boba_fett_krayts_claw_commander.png"),
  const Leader(id:311, name:"Director Krennic, Amidst My Achievement", imagePath: "assets/images/leaders/director_krennic_amidst_my_achievement.png"),
  const Leader(id:312, name:"Hera Syndulla, Not Fighting Alone", imagePath: "assets/images/leaders/hera_syndulla_not_fighting_alone.png"),
  const Leader(id:313, name:"Leia Organa, Someone Who Loves You", imagePath: "assets/images/leaders/leia_organa_someone_who_loves_you.png"),
  const Leader(id:314, name:"Darth Vader, Unstoppable", imagePath: "assets/images/leaders/darth_vader_unstoppable.png"),
  const Leader(id:315, name:"Sebulba, Especially Dangerous Dug", imagePath: "assets/images/leaders/sebulba_especially_dangerous_dug.png"),
  const Leader(id:316, name:"Chewbacca, Hero of Kessel", imagePath: "assets/images/leaders/chewbacca_hero_of_kessel.png"),
  const Leader(id:317, name:"Enfys Nest, Until We Can Go No Higher", imagePath: "assets/images/leaders/enfys_nest_until_we_can_go_no_higher.png"),
  const Leader(id:318, name:"Jabba the Hutt, Crime Boss", imagePath: "assets/images/leaders/jabba_the_hutt_crime_boss.png"),
  const Leader(id:319, name:"The Client, Please Lower Your Blaster", imagePath: "assets/images/leaders/the_client_please_lower_your_blaster.png"),
  const Leader(id:320, name:"Han Solo, I Got a Really Good Feeling", imagePath: "assets/images/leaders/han_solo_i_got_a_really_good_feeling.png"),
  const Leader(id:321, name:"Lando Calrissian, Full Sabacc", imagePath: "assets/images/leaders/lando_calrissian_full_sabacc.png"),

  // LAW showcases
  const Leader(id:322, name:"Saw Gerrara, Bring Down the Empire(Showcase)", imagePath: "assets/images/leaders/saw_gerrara_bring_down_the_empire_showcase.png"),
  const Leader(id:323, name:"Tobias Beckett, People Are Predictable(Showcase)", imagePath: "assets/images/leaders/tobias_beckett_people_are_predictable_showcase.png"),
  const Leader(id:324, name:"Agent Kallus, Reconsider Your Allegiance(Showcase)", imagePath: "assets/images/leaders/agent_kallus_reconsider_your_allegiance_showcase.png"),
  const Leader(id:325, name:"Aurra Sing, Assassin(Showcase)", imagePath: "assets/images/leaders/aurra_sing_assassin_showcase.png"),
  const Leader(id:326, name:"Jyn Erso, Time to Fight(Showcase)", imagePath: "assets/images/leaders/jyn_erso_time_to_fight_showcase.png"),
  const Leader(id:327, name:"Vel Sartha, Aldhani Insurgent(Showcase)", imagePath: "assets/images/leaders/vel_sartha_aldhani_insurgent_showcase.png"),
  const Leader(id:328, name:"Boba Fett, Krayt's Claw Commander(Showcase)", imagePath: "assets/images/leaders/boba_fett_krayts_claw_commander_showcase.png"),
  const Leader(id:329, name:"Director Krennic, Amidst My Achievement(Showcase)", imagePath: "assets/images/leaders/director_krennic_amidst_my_achievement_showcase.png"),
  const Leader(id:330, name:"Hera Syndulla, Not Fighting Alone(Showcase)", imagePath: "assets/images/leaders/hera_syndulla_not_fighting_alone_showcase.png"),
  const Leader(id:331, name:"Leia Organa, Someone Who Loves You(Showcase)", imagePath: "assets/images/leaders/leia_organa_someone_who_loves_you_showcase.png"),
  const Leader(id:332, name:"Darth Vader, Unstoppable(Showcase)", imagePath: "assets/images/leaders/darth_vader_unstoppable_showcase.png"),
  const Leader(id:333, name:"Sebulba, Especially Dangerous Dug(Showcase)", imagePath: "assets/images/leaders/sebulba_especially_dangerous_dug_showcase.png"),
  const Leader(id:334, name:"Chewbacca, Hero of Kessel(Showcase)", imagePath: "assets/images/leaders/chewbacca_hero_of_kessel_showcase.png"),
  const Leader(id:335, name:"Enfys Nest, Until We Can Go No Higher(Showcase)", imagePath: "assets/images/leaders/enfys_nest_until_we_can_go_no_higher_showcase.png"),
  const Leader(id:336, name:"Jabba the Hutt, Crime Boss(Showcase)", imagePath: "assets/images/leaders/jabba_the_hutt_crime_boss_showcase.png"),
  const Leader(id:337, name:"The Client, Please Lower Your Blaster(Showcase)", imagePath: "assets/images/leaders/the_client_please_lower_your_blaster_showcase.png"),
  const Leader(id:338, name:"Han Solo, I Got a Really Good Feeling(Showcase)", imagePath: "assets/images/leaders/han_solo_i_got_a_really_good_feeling_showcase.png"),
  const Leader(id:339, name:"Lando Calrissian, Full Sabacc(Showcase)", imagePath: "assets/images/leaders/lando_calrissian_full_sabacc_showcase.png"),

  // ASH Leaders
  const Leader(id:340, name:"The Armorer, Steel Shapes Us", imagePath: "assets/images/leaders/the_armorer_steel_shapes_us.png"),
  const Leader(id:341, name:"Fennec Shand, Ready For War", imagePath: "assets/images/leaders/fennec_shand_ready_for_war.png"),
  const Leader(id:342, name:"Baylan Skoll, Power Beyond Dreams", imagePath: "assets/images/leaders/baylan_skoll_power_beyond_dreams.png"),
  const Leader(id:343, name:"Grand Admiral Thrawn, Victory Is Mine", imagePath: "assets/images/leaders/grand_admiral_thrawn_victory_is_mine.png"),
  const Leader(id:344, name:"Luke Skywalker, I Can Save Him", imagePath: "assets/images/leaders/luke_skywalker_i_can_save_him.png"),
  const Leader(id:345, name:"Sabine Wren, Bargaining On Belief", imagePath: "assets/images/leaders/sabine_wren_bargaining_on_belief.png"),
  const Leader(id:346, name:"Grand Admiral Sloane, Holding the Emperor Together", imagePath: "assets/images/leaders/grand_admiral_sloane_holding_the_emperor_together.png"),
  const Leader(id:347, name:"Moff Gideon, Indomitable Warlord", imagePath: "assets/images/leaders/moff_gideon_indomitable_warlord.png"),
  const Leader(id:348, name:"Ahsoka Tano, Trust in the Force", imagePath: "assets/images/leaders/ahsoka_tano_trust_in_the_force.png"),
  const Leader(id:349, name:"Bo-Katan Kryze, Reclaiming Mandalore", imagePath: "assets/images/leaders/bo-katan_kryze_reclaiming_mandalore.png"),
  const Leader(id:350, name:"Cad Bane, Still Faster Than You", imagePath: "assets/images/leaders/cad_bane_still_faster_than_you.png"),
  const Leader(id:351, name:"Vane, Quarrelsome Pirate", imagePath: "assets/images/leaders/vane_quarrelsome_pirate.png"),
  const Leader(id:352, name:"Ezra Bridger, It's Now or Never", imagePath: "assets/images/leaders/ezra_bridger_it's_now_or_never.png"),
  const Leader(id:353, name:"The Mandalorian, We Can't Keep Running", imagePath: "assets/images/leaders/the_mandalorian_we_can't_keep_running.png"),
  const Leader(id:354, name:"Emperor Palpatine, According to my Design", imagePath: "assets/images/leaders/emperor_palpatine_according_to_my_design.png"),
  const Leader(id:355, name:"Shin Hati, Eager Adversary", imagePath: "assets/images/leaders/shin_hati_eager_adversary.png"),
  const Leader(id:356, name:"Greef Karga, Gracious Magistrate", imagePath: "assets/images/leaders/greef_karga_gracious_magistrate.png"),
  const Leader(id:357, name:"Grogu, Charming Companion", imagePath: "assets/images/leaders/grogu_charming_companion.png"),

  // ASH showcases
  const Leader(id:358, name:"The Armorer, Steel Shapes Us (Showcase)", imagePath: "assets/images/leaders/the_armorer_steel_shapes_us_showcase.png"),
  const Leader(id:359, name:"Fennec Shand, Ready For War (Showcase)", imagePath: "assets/images/leaders/fennec_shand_ready_for_war_showcase.png"),
  const Leader(id:360, name:"Baylan Skoll, Power Beyond Dreams(Showcase)", imagePath: "assets/images/leaders/baylan_skoll_power_beyond_dreams_showcase.png"),
  const Leader(id:361, name:"Grand Admiral Thrawn, Victory Is Mine(Showcase)", imagePath: "assets/images/leaders/grand_admiral_thrawn_victory_is_mine_showcase.png"),
  const Leader(id:362, name:"Luke Skywalker, I Can Save Him(Showcase)", imagePath: "assets/images/leaders/luke_skywalker_i_can_save_him_showcase.png"),
  const Leader(id:363, name:"Sabine Wren, Bargaining On Belief(Showcase)", imagePath: "assets/images/leaders/sabine_wren_bargaining_on_belief_showcase.png"),
  const Leader(id:364, name:"Grand Admiral Sloane, Holding the Emperor Together(Showcase)", imagePath: "assets/images/leaders/grand_admiral_sloane_holding_the_emperor_together_showcase.png"),
  const Leader(id:365, name:"Moff Gideon, Indomitable Warlord(Showcase)", imagePath: "assets/images/leaders/moff_gideon_indomitable_warlord_showcase.png"),
  const Leader(id:366, name:"Ahsoka Tano, Trust in the Force(Showcase)", imagePath: "assets/images/leaders/ahsoka_tano_trust_in_the_force_showcase.png"),
  const Leader(id:367, name:"Bo-Katan Kryze, Reclaiming Mandalore(Showcase)", imagePath: "assets/images/leaders/bo-katan_kryze_reclaiming_mandalore_showcase.png"),
  const Leader(id:368, name:"Cad Bane, Still Faster Than You(Showcase)", imagePath: "assets/images/leaders/cad_bane_still_faster_than_you_showcase.png"),
  const Leader(id:369, name:"Vane, Quarrelsome Pirate(Showcase)", imagePath: "assets/images/leaders/vane_quarrelsome_pirate_showcase.png"),
  const Leader(id:370, name:"Ezra Bridger, It's Now or Never(Showcase)", imagePath: "assets/images/leaders/ezra_bridger_it's_now_or_never_showcase.png"),
  const Leader(id:371, name:"The Mandalorian, We Can't Keep Running(Showcase)", imagePath: "assets/images/leaders/the_mandalorian_we_can't_keep_running_showcase.png"),
  const Leader(id:372, name:"Emperor Palpatine, According to my Design(Showcase)", imagePath: "assets/images/leaders/emperor_palpatine_according_to_my_design_showcase.png"),
  const Leader(id:373, name:"Shin Hati, Eager Adversary(Showcase)", imagePath: "assets/images/leaders/shin_hati_eager_adversary_showcase.png"),
  const Leader(id:374, name:"Greef Karga, Gracious Magistrate(Showcase)", imagePath: "assets/images/leaders/greef_karga_gracious_magistrate_showcase.png"),
  const Leader(id:375, name:"Grogu, Charming Companion(Showcase)", imagePath: "assets/images/leaders/grogu_charming_companion_showcase.png"),











];
