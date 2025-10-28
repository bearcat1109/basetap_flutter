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
  const Leader(id: 61, name: "Darth Vader, Victor Squadron Leader", imagePath: "assets/images/leaders/darth_vader_victor_squadron_leader.jpg"),
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

  // Showcase images
  const Leader(id: 101, name: "Yoda, Sensing Darkness (Showcase)", imagePath: "assets/images/leaders/yoda_sensing_darkness_showcase.webp"),
  const Leader(id: 102, name: "Captain Rex, Fighting for His Brothers (Showcase)", imagePath: "assets/images/leaders/captain_rex_fighting_for_his_brothers_showcase.webp"),
  const Leader(id: 105, name: "Han Solo, Audacious Smuggler (Showcase)", imagePath: "assets/images/leaders/han_solo_audacious_smuggler_showcase.webp"),
  const Leader(id: 106, name: "Obi-Wan Kenobi, Patient Mentor (Showcase)", imagePath: "assets/images/leaders/obi_wan_kenobi_patient_mentor_showcase.webp"),
  const Leader(id: 107, name: "Emperor Palpatine, Galactic Ruler (Showcase)", imagePath: "assets/images/leaders/emperor_palpatine_galactic_ruler_showcase.webp"),
  const Leader(id: 108, name: "Ahsoka Tano, Snips (Showcase)", imagePath: "assets/images/leaders/ahsoka_tano_snips_showcase.webp"),
  const Leader(id: 109, name: "Boba Fett, Daimyo (Showcase)", imagePath: "assets/images/leaders/boba_fett_daimyo_showcase.webp"),
  const Leader(id: 110, name: "Maul, a Rival in Darkness (Showcase)", imagePath: "assets/images/leaders/maul_a_rival_in_darkness_showcase.webp"),
  const Leader(id: 111, name: "Cassian Andor, Dedicated to the Rebellion (Showcase)", imagePath: "assets/images/leaders/cassian_andor_dedicated_to_the_rebellion_showcase.webp"),
  const Leader(id: 112, name: "Jyn Erso, Resisting Oppression (Showcase)", imagePath: "assets/images/leaders/jyn_erso_resisting_oppression_showcase.webp"),
  const Leader(id: 113, name: "Sabine Wren, Galvanized Revolutionary (Showcase)", imagePath: "assets/images/leaders/sabine_wren_galvanized_revolutionary_showcase.webp"),
  const Leader(id: 114, name: "Boba Fett, Collecting the Bounty (Showcase)", imagePath: "assets/images/leaders/boba_fett_collecting_the_bounty_showcase.webp"),
  const Leader(id: 115, name: "IG-88, Ruthless Bounty Hunter (Showcase)", imagePath: "assets/images/leaders/ig_88_ruthless_bounty_hunter_showcase.webp"),
  const Leader(id: 116, name: "Grand Inquisitor, Hunting the Jedi (Showcase)", imagePath: "assets/images/leaders/grand_inquisitor_hunting_the_jedi_showcase.webp"),
  const Leader(id: 117, name: "Leia Organa, Alliance General (Showcase)", imagePath: "assets/images/leaders/leia_organa_alliance_general_showcase.webp"),
  const Leader(id: 118, name: "Hera Syndulla, Spectre Two (Showcase)", imagePath: "assets/images/leaders/hera_syndulla_spectre_two_showcase.webp"),
  const Leader(id: 119, name: "Grand Moff Tarkin, Oversector Governor (Showcase)", imagePath: "assets/images/leaders/grand_moff_tarkin_oversector_governor_showcase.webp"),
  const Leader(id: 120, name: "Chirrut Imwe, One with the Force (Showcase)", imagePath: "assets/images/leaders/chirrut_imwe_one_with_the_force_showcase.webp"),
  const Leader(id: 121, name: "Chewbacca, Walking Carpet (Showcase)", imagePath: "assets/images/leaders/chewbacca_walking_carpet_showcase.webp"),
  const Leader(id: 122, name: "Iden Versio, Inferno Squad Commander (Showcase)", imagePath: "assets/images/leaders/iden_versio_inferno_squad_commander_showcase.webp"),
  const Leader(id: 123, name: "Director Krennic, Aspiring to Authority (Showcase)", imagePath: "assets/images/leaders/director_krennic_aspiring_to_authority_showcase.webp"),
  const Leader(id: 124, name: "The Mandalorian, Sworn to the Creed (Showcase)", imagePath: "assets/images/leaders/the_mandalorian_sworn_to_the_creed_showcase.webp"),
  const Leader(id: 125, name: "Lando Calrissian, With Impeccable Taste (Showcase)", imagePath: "assets/images/leaders/lando_calrissian_with_impeccable_taste_showcase.webp"),
  const Leader(id: 126, name: "Fennec Shand, Honoring the Deal (Showcase)", imagePath: "assets/images/leaders/fennec_shand_honoring_the_deal_showcase.webp"),
  const Leader(id: 127, name: "Doctor Aphra, Rapacious Archaeologist (Showcase)", imagePath: "assets/images/leaders/doctor_aphra_rapacious_archaeologist_showcase.webp"),
  const Leader(id: 128, name: "Cad Bane, He Who Needs No Introduction (Showcase)", imagePath: "assets/images/leaders/cad_bane_he_who_needs_no_introduction_showcase.webp"),
  const Leader(id: 129, name: "Han Solo, Worth the Risk (Showcase)", imagePath: "assets/images/leaders/han_solo_worth_the_risk_showcase.webp"),
  const Leader(id: 130, name: "Bo Katan Kryze, Princess in Exile (Showcase)", imagePath: "assets/images/leaders/bo_katan_kryze_princess_in_exile_showcase.webp"),
  const Leader(id: 131, name: "Kylo Ren, Rash and Deadly (Showcase)", imagePath: "assets/images/leaders/kylo_ren_rash_and_deadly_showcase.webp"),
  const Leader(id: 132, name: "Bossk, Hunting His Prey (Showcase)", imagePath: "assets/images/leaders/bossk_hunting_his_prey_showcase.webp"),
  const Leader(id: 133, name: "Hunter, Outcast Sergeant (Showcase)", imagePath: "assets/images/leaders/hunter_outcast_sergeant_showcase.webp"),
  const Leader(id: 134, name: "Moff Gideon, Formidable Commander (Showcase)", imagePath: "assets/images/leaders/moff_gideon_formidable_commander_showcase.webp"),
  const Leader(id: 135, name: "Jabba the Hutt, His High Exaltedness (Showcase)", imagePath: "assets/images/leaders/jabba_the_hutt_his_high_exaltedness_showcase.webp"),
  const Leader(id: 136, name: "Hondo Ohnaka, That's Good Business (Showcase)", imagePath: "assets/images/leaders/hondo_ohnaka_thats_good_business_showcase.webp"),
  const Leader(id: 137, name: "Rey, More Than a Scavenger (Showcase)", imagePath: "assets/images/leaders/rey_more_than_a_scavenger_showcase.webp"),
  const Leader(id: 138, name: "Finn, This is a Rescue (Showcase)", imagePath: "assets/images/leaders/finn_this_is_a_rescue_showcase.webp"),
  const Leader(id: 139, name: "Qira, I Alone Survived (Showcase)", imagePath: "assets/images/leaders/qira_i_alone_survived_showcase.webp"),
  const Leader(id: 140, name: "Gar Saxon, Viceroy of Mandalore (Showcase)", imagePath: "assets/images/leaders/gar_saxon_viceroy_of_mandalore_showcase.webp"),
  const Leader(id: 141, name: "Quinlan Vos, Sticking the Landing (Showcase)", imagePath: "assets/images/leaders/quinlan_vos_sticking_the_landing_showcase.webp"),
  const Leader(id: 142, name: "Chancellor Palpatine, Playing Both Sides (Showcase)", imagePath: "assets/images/leaders/chancellor_palpatine_playing_both_sides_showcase.webp"),
  const Leader(id: 143, name: "Jango Fett, Concealing the Conspiracy (Showcase)", imagePath: "assets/images/leaders/jango_fett_concealing_the_conspiracy_showcase.webp"),
  const Leader(id: 144, name: "General Grievous, General of the Droid Armies (Showcase)", imagePath: "assets/images/leaders/general_grievous_general_of_the_droid_armies_showcase.webp"),
  const Leader(id: 145, name: "Asajj Ventress, Unparalleled Adversary (Showcase)", imagePath: "assets/images/leaders/asajj_ventress_unparalleled_adversary_showcase.webp"),
  const Leader(id: 146, name: "Mace Windu, Vaapad Form Master (Showcase)", imagePath: "assets/images/leaders/mace_windu_vaapad_form_master_showcase.webp"),
  const Leader(id: 147, name: "Anakin Skywalker, What It Takes to Win (Showcase)", imagePath: "assets/images/leaders/anakin_skywalker_what_it_takes_to_win_showcase.webp"),
  const Leader(id: 148, name: "Pre Vizsla, Pursuing the Throne (Showcase)", imagePath: "assets/images/leaders/pre_vizsla_pursuing_the_throne_showcase.webp"),
  const Leader(id: 149, name: "Padme Amidala, Serving the Republic (Showcase)", imagePath: "assets/images/leaders/padme_amidala_serving_the_republic_showcase.webp"),
  const Leader(id: 150, name: "Wat Tambor, Techno Union Foreman (Showcase)", imagePath: "assets/images/leaders/wat_tambor_techno_union_foreman_showcase.webp"),
  const Leader(id: 151, name: "Count Dooku, Face of the Confederacy (Showcase)", imagePath: "assets/images/leaders/count_dooku_face_of_the_confederacy_showcase.webp"),
  const Leader(id: 152, name: "Nute Gunray, Vindictive Viceroy (Showcase)", imagePath: "assets/images/leaders/nute_gunray_vindictive_viceroy_showcase.webp"),
  const Leader(id: 153, name: "Nala Se, Clone Engineer (Showcase)", imagePath: "assets/images/leaders/nala_se_clone_engineer_showcase.webp"),

  // Set 4 Showcases
  const Leader(id: 154, name: "Asajj Ventress, I Work Alone (Showcase)", imagePath: "assets/images/leaders/asajj_ventress_i_work_alone_showcase.webp"),
  const Leader(id: 155, name: "Grand Admiral Thrawn, ...How Unfortunate (Showcase)", imagePath: "assets/images/leaders/grand_admiral_thrawn_how_unfortunate_showcase.webp"),
  const Leader(id: 156, name: "Lando Calrissian, Buying Time (Showcase)", imagePath: "assets/images/leaders/lando_calrissian_buying_time_showcase.webp"),
  const Leader(id: 157, name: "Rose Tico, Saving What We Love (Showcase)", imagePath: "assets/images/leaders/rose_tico_saving_what_we_love_showcase.webp"),
  const Leader(id: 158, name: "Admiral Piett, Commanding the Armada (Showcase)", imagePath: "assets/images/leaders/admiral_piett_commanding_the_armada_showcase.webp"),
  const Leader(id: 159, name: "Admiral Holdo, We're Not Alone (Showcase)", imagePath: "assets/images/leaders/admiral_holdo_were_not_alone_showcase.webp"),
  const Leader(id: 160, name: "Wedge Antilles, Leader of Red Squadron (Showcase)", imagePath: "assets/images/leaders/wedge_antilles_leader_of_red_squadron_showcase.webp"),
  const Leader(id: 161, name: "Boba Fett, Any Methods Necessary (Showcase)", imagePath: "assets/images/leaders/boba_fett_any_methods_necessary_showcase.webp"),
  const Leader(id: 162, name: "Captain Phasma, Chrome Dome (Showcase)", imagePath: "assets/images/leaders/captain_phasma_chrome_dome_showcase.webp"),
  const Leader(id: 163, name: "Luke Skywalker, Hero of Yavin (Showcase)", imagePath: "assets/images/leaders/luke_skywalker_hero_of_yavin_showcase.webp"),
  const Leader(id: 164, name: "Poe Dameron, I Can Fly Anything (Showcase)", imagePath: "assets/images/leaders/poe_dameron_i_can_fly_anything_showcase.webp"),
  const Leader(id: 165, name: "Admiral Trench, Chk Chk Chk Chk (Showcase)", imagePath: "assets/images/leaders/admiral_trench_chk_chk_chk_chk_showcase.webp"),
  const Leader(id: 166, name: "Rio Durant, Wisecracking Wheelman (Showcase)", imagePath: "assets/images/leaders/rio_durant_wisecracking_wheelman_showcase.webp"),
  const Leader(id: 167, name: "Admiral Ackbar, It's a Trap! (Showcase)", imagePath: "assets/images/leaders/admiral_ackbar_its_a_trap_showcase.webp"),
  const Leader(id: 168, name: "Han Solo, Never Tell Me The Odds (Showcase)", imagePath: "assets/images/leaders/han_solo_never_tell_me_the_odds_showcase.webp"),
  const Leader(id: 169, name: "Kazuda Xiono, Best Pilot in the Galaxy (Showcase)", imagePath: "assets/images/leaders/kazuda_xiono_best_pilot_in_the_galaxy_showcase.webp"),
  const Leader(id: 170, name: "Major Vonreg, Red Baron (Showcase)", imagePath: "assets/images/leaders/major_vonreg_red_baron_showcase.jpg"),
];
