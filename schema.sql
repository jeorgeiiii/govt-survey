-- Supabase Postgres Schema for Family Survey App
-- This schema is designed for offline-first with SQLite sync to Supabase

-- Main Survey Table
CREATE TABLE surveys (
    id SERIAL PRIMARY KEY,
    survey_date DATE NOT NULL DEFAULT CURRENT_DATE,
    village_name VARCHAR(255),
    panchayat VARCHAR(255),
    block VARCHAR(255),
    tehsil VARCHAR(255),
    district VARCHAR(255),
    postal_address TEXT,
    pin_code VARCHAR(10),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    synced BOOLEAN DEFAULT FALSE
);

-- Family Details Table
CREATE TABLE family_details (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    member_name VARCHAR(255),
    age INTEGER,
    sex VARCHAR(10),
    relation VARCHAR(50),
    education VARCHAR(100),
    occupation VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Land Holding Table
CREATE TABLE land_holding (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    irrigated_area DECIMAL(10,2),
    cultivable_area DECIMAL(10,2),
    orchard_plants TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Irrigation Facilities Table
CREATE TABLE irrigation_facilities (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    canal BOOLEAN DEFAULT FALSE,
    tube_well BOOLEAN DEFAULT FALSE,
    ponds BOOLEAN DEFAULT FALSE,
    other_facilities TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crop Productivity Table
CREATE TABLE crop_productivity (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    crop_name VARCHAR(255),
    area_acres DECIMAL(10,2),
    productivity_quintal_per_acre DECIMAL(10,2),
    total_production DECIMAL(10,2),
    quantity_consumed DECIMAL(10,2),
    quantity_sold_quintal DECIMAL(10,2),
    quantity_sold_rupees DECIMAL(10,2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Fertilizer Usage Table
CREATE TABLE fertilizer_usage (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    chemical BOOLEAN DEFAULT FALSE,
    organic BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Animals Table
CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    animal_type VARCHAR(100),
    number_of_animals INTEGER,
    breed VARCHAR(100),
    production_per_animal DECIMAL(10,2),
    quantity_sold DECIMAL(10,2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Agricultural Equipment Table
CREATE TABLE agricultural_equipment (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    tractor BOOLEAN DEFAULT FALSE,
    thresher BOOLEAN DEFAULT FALSE,
    seed_drill BOOLEAN DEFAULT FALSE,
    sprayer BOOLEAN DEFAULT FALSE,
    duster BOOLEAN DEFAULT FALSE,
    diesel_engine BOOLEAN DEFAULT FALSE,
    other_equipment TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Entertainment Facilities Table
CREATE TABLE entertainment_facilities (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    smart_mobile BOOLEAN DEFAULT FALSE,
    smart_mobile_count INTEGER,
    analog_mobile BOOLEAN DEFAULT FALSE,
    analog_mobile_count INTEGER,
    television BOOLEAN DEFAULT FALSE,
    radio BOOLEAN DEFAULT FALSE,
    games BOOLEAN DEFAULT FALSE,
    other_entertainment TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Transport Facilities Table
CREATE TABLE transport_facilities (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    car_jeep BOOLEAN DEFAULT FALSE,
    motorcycle_scooter BOOLEAN DEFAULT FALSE,
    e_rickshaw BOOLEAN DEFAULT FALSE,
    cycle BOOLEAN DEFAULT FALSE,
    pickup_truck BOOLEAN DEFAULT FALSE,
    bullock_cart BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Drinking Water Sources Table
CREATE TABLE drinking_water_sources (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    hand_pumps BOOLEAN DEFAULT FALSE,
    hand_pumps_distance DECIMAL(5,2),
    well BOOLEAN DEFAULT FALSE,
    well_distance DECIMAL(5,2),
    tubewell BOOLEAN DEFAULT FALSE,
    tubewell_distance DECIMAL(5,2),
    nal_jaal BOOLEAN DEFAULT FALSE,
    other_sources TEXT,
    other_distance DECIMAL(5,2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Medical Treatment Methods Table
CREATE TABLE medical_treatment (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    allopathic BOOLEAN DEFAULT FALSE,
    ayurvedic BOOLEAN DEFAULT FALSE,
    homeopathy BOOLEAN DEFAULT FALSE,
    traditional BOOLEAN DEFAULT FALSE,
    jhad_phook BOOLEAN DEFAULT FALSE,
    other_methods TEXT,
    preferences TEXT[],
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Disputes Table
CREATE TABLE disputes (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    family_disputes BOOLEAN DEFAULT FALSE,
    family_registered BOOLEAN DEFAULT FALSE,
    revenue_disputes BOOLEAN DEFAULT FALSE,
    revenue_registered BOOLEAN DEFAULT FALSE,
    criminal_disputes BOOLEAN DEFAULT FALSE,
    criminal_registered BOOLEAN DEFAULT FALSE,
    other_disputes TEXT,
    dispute_period VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- House Conditions Table
CREATE TABLE house_conditions (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    katcha BOOLEAN DEFAULT FALSE,
    pakka BOOLEAN DEFAULT FALSE,
    katcha_pakka BOOLEAN DEFAULT FALSE,
    hut BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- House Facilities Table
CREATE TABLE house_facilities (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    toilet BOOLEAN DEFAULT FALSE,
    toilet_in_use BOOLEAN DEFAULT FALSE,
    drainage BOOLEAN DEFAULT FALSE,
    soak_pit BOOLEAN DEFAULT FALSE,
    cattle_shed BOOLEAN DEFAULT FALSE,
    compost_pit BOOLEAN DEFAULT FALSE,
    nadep BOOLEAN DEFAULT FALSE,
    lpg_gas BOOLEAN DEFAULT FALSE,
    biogas BOOLEAN DEFAULT FALSE,
    solar_cooking BOOLEAN DEFAULT FALSE,
    electric_connection BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Nutritional Kitchen Garden Table
CREATE TABLE nutritional_garden (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    available BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Serious Diseases Table
CREATE TABLE serious_diseases (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    member_name VARCHAR(255),
    age INTEGER,
    sex VARCHAR(10),
    disease_name VARCHAR(255),
    suffering_since VARCHAR(100),
    treatment_from VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Government Schemes Table
CREATE TABLE government_schemes (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    scheme_type VARCHAR(50), -- aadhaar, ayushman, family_id, ration_card, etc.
    have_card BOOLEAN DEFAULT FALSE,
    name_included BOOLEAN DEFAULT FALSE,
    details_correct BOOLEAN DEFAULT FALSE,
    member_name VARCHAR(255),
    age INTEGER,
    sex VARCHAR(10),
    eligible BOOLEAN DEFAULT FALSE,
    registered BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Folklore Medicine Table
CREATE TABLE folklore_medicine (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    person_name VARCHAR(255),
    plant_local_name VARCHAR(255),
    plant_botanical_name VARCHAR(255),
    plant_uses TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Health Programs Table
CREATE TABLE health_programs (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    pregnancy_vaccination BOOLEAN DEFAULT FALSE,
    child_vaccination BOOLEAN DEFAULT FALSE,
    vaccination_completed BOOLEAN DEFAULT FALSE,
    vaccination_schedule TEXT,
    family_planning_awareness BOOLEAN DEFAULT FALSE,
    contraceptive_applied BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Children's Data Table
CREATE TABLE children_data (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    births_last_3_years INTEGER DEFAULT 0,
    infant_deaths_last_3_years INTEGER DEFAULT 0,
    malnourished_children INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Malnutrition Data Table
CREATE TABLE malnutrition_data (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    member_name VARCHAR(255),
    sex VARCHAR(10),
    age INTEGER,
    height_feet DECIMAL(4,2),
    weight_kg DECIMAL(5,2),
    cause_disease TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tulsi Plants Table
CREATE TABLE tulsi_plants (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    available BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Migration Table
CREATE TABLE migration (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    migration_type VARCHAR(50), -- permanent, seasonal, as_needed
    member_name VARCHAR(255),
    distance VARCHAR(100),
    job_description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Training Table
CREATE TABLE training (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    member_name VARCHAR(255),
    training_type VARCHAR(255),
    institute VARCHAR(255),
    year_of_passing INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Self Help Groups Table
CREATE TABLE self_help_groups (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    member_name VARCHAR(255),
    shg_name VARCHAR(255),
    purpose TEXT,
    agency VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Farmer Producer Organizations Table
CREATE TABLE fpo_membership (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    member_name VARCHAR(255),
    fpo_name VARCHAR(255),
    purpose TEXT,
    agency VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Government Beneficiary Programs Table
CREATE TABLE beneficiary_programs (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    program_type VARCHAR(100), -- vb_gram, pm_kisan_nidhi, pm_kisan_samman, kisan_credit_card, swachh_bharat, fasal_bima
    beneficiary BOOLEAN DEFAULT FALSE,
    name_included BOOLEAN DEFAULT FALSE,
    details_correct BOOLEAN DEFAULT FALSE,
    received BOOLEAN DEFAULT FALSE,
    member_name VARCHAR(255),
    days_worked INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Bank Accounts Table
CREATE TABLE bank_accounts (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    member_name VARCHAR(255),
    has_account BOOLEAN DEFAULT FALSE,
    details_correct BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Social Consciousness Survey Table (from separate sheet)
CREATE TABLE social_consciousness (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    question_number INTEGER,
    response TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tribal Additional Questions Table
CREATE TABLE tribal_questions (
    id SERIAL PRIMARY KEY,
    survey_id INTEGER REFERENCES surveys(id) ON DELETE CASCADE,
    individual_forest_claims TEXT,
    claim_map TEXT,
    palash_leaf_collector BOOLEAN DEFAULT FALSE,
    collection_areas TEXT,
    honey_gatherer BOOLEAN DEFAULT FALSE,
    honey_collection_areas TEXT,
    ntfp_identification TEXT,
    stakeholder_shgs TEXT,
    skills_identification TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for better performance
CREATE INDEX idx_surveys_synced ON surveys(synced);
CREATE INDEX idx_family_details_survey_id ON family_details(survey_id);
CREATE INDEX idx_land_holding_survey_id ON land_holding(survey_id);
CREATE INDEX idx_crop_productivity_survey_id ON crop_productivity(survey_id);
CREATE INDEX idx_animals_survey_id ON animals(survey_id);
CREATE INDEX idx_government_schemes_survey_id ON government_schemes(survey_id);
CREATE INDEX idx_beneficiary_programs_survey_id ON beneficiary_programs(survey_id);

-- Updated at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply updated_at trigger to surveys table
CREATE TRIGGER update_surveys_updated_at BEFORE UPDATE ON surveys
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
