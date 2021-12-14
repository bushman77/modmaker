defmodule ShipObj do

  use Memento.Table,
    attributes: [
      :id,
      :entityType,
      :defaultAutoAttackRange,
      :defaultAutoAttackOn,
      :prefersToFocusFire,
      :usesFighterAttack,
      :autoJoinFleetDefault,
      :canBomb,
      :hasBombingLevels,
      :baseDamage,
      :basePopulationKilled,
      :bombingFreqTime,
      :baseRange,
      :bombTransitTime,
      :bombEffectCount,
      :bombEffectAngleVariance,
      :bombEffectsDef,
      :typeCount,
      :statCountType,
      :mainViewIcon,
      :picture,
      :NameStringID,
      :DescriptionStringID,
      :counterDescriptionStringID,
      :basePrice,
      :slotCount,
      :BuildTime,
      :hasLevels,
      :ExperiencePointsForDestroying,
      :MaxHullPoints,
      :MaxShieldPoints,
      :HullPointRestoreRate,
      :ShieldPointRestoreRate,
      :BaseArmorPoints,
      :maxMitigation,
      :relationshipChangeRate,
      :Prerequisites,
      :numRandomDebrisLarge,
      :numRandomDebrisSmall,
      :numSpecificDebris,
      :armorType,
      :hudIcon,
      :smallHudIcon,
      :infoCardIcon,
      :minZoomDistanceMult,
      :NumWeapons,
      :m_weaponIndexForRange
    ],
    index: [:NameStringID],
    type: :ordered_set,
    autoincrement: true




  def bombEffectsDef() do
    %{ weaponType: "",
       burstCount: 0,
       burstDelay: 0.000000,
       fireDelay: 0.000000,
       muzzleEffectName: "",
       muzzleSoundMinRespawnTime: 0.100000,
       muzzleSounds: [],
       hitEffectName: "",
       hitHullEffectSounds: [],
       hitShieldsEffectSounds: [],
       beamEffectSounds: %{
         sounds: [],
         beamGlowTextureName: "",
         beamCoreTextureName: ""
       },
      beamWidth: 0.000000,
      beamGlowColor: "ff777777",
      beamCoreColor: "ffffffff",
      beamTilingRate: 0.000000
    }
  end


  def baseprice, do: %{credits: 0.000000, metal: 0.000000, crystal: 0.000000}


end
