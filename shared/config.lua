-- Shared Configuration
Config = {}

-- House Shells (different interior types)
Config.HouseShells = {
    {
        id = 1,
        name = "Modern Apartment",
        interior = "v_apt_m_ch1_cv_1",
        spawn = vector3(374.26, 416.1, 145.49),
        price_multiplier = 1.0,
    },
    {
        id = 2,
        name = "Luxury Penthouse",
        interior = "v_apt_m_ch2_cv_1",
        spawn = vector3(288.82, 313.11, 103.46),
        price_multiplier = 1.5,
    },
    {
        id = 3,
        name = "Stylish Loft",
        interior = "v_apt_m_ch3_cv_1",
        spawn = vector3(265.28, 220.1, 106.28),
        price_multiplier = 1.2,
    },
}

-- Available Decorations
Config.Decorations = {
    {
        id = 1,
        name = "Leather Sofa",
        price = 500,
        model = "prop_sofa_01",
    },
    {
        id = 2,
        name = "Wooden Table",
        price = 300,
        model = "prop_table_04",
    },
    {
        id = 3,
        name = "Computer Desk",
        price = 800,
        model = "prop_des_03",
    },
    {
        id = 4,
        name = "Bathroom Vanity",
        price = 400,
        model = "prop_bathroom_sink_01",
    },
    {
        id = 5,
        name = "Bed Frame",
        price = 1200,
        model = "prop_bed_01",
    },
    {
        id = 6,
        name = "Kitchen Counter",
        price = 600,
        model = "prop_kitchen_counter",
    },
    {
        id = 7,
        name = "Floor Lamp",
        price = 200,
        model = "prop_lamp_01",
    },
    {
        id = 8,
        name = "Plant Pot",
        price = 150,
        model = "prop_pot_plant_01",
    },
    {
        id = 9,
        name = "Bookshelf",
        price = 700,
        model = "prop_bookshelf_03",
    },
    {
        id = 10,
        name = "TV Stand",
        price = 1000,
        model = "prop_tv_stand_01",
    },
}

-- Real Estate Agent Job Config
Config.RealEstateJob = {
    name = "realestate",
    label = "Real Estate Agent",
    blip = {
        sprite = 350,
        color = 2,
        scale = 0.7,
    },
    spawn = vector3(346.87, -988.37, 29.44),
}

-- Default Houses
Config.Houses = {
    {
        id = 1,
        name = "Pillbox Apartment",
        basePrice = 50000,
        shell = 1,
        exterior = vector3(346.87, -988.37, 29.44),
        heading = 0.0,
    },
    {
        id = 2,
        name = "Downtown Penthouse",
        basePrice = 150000,
        shell = 2,
        exterior = vector3(-583.67, -1047.30, 27.52),
        heading = 0.0,
    },
    {
        id = 3,
        name = "Rockford Hills Estate",
        basePrice = 250000,
        shell = 3,
        exterior = vector3(-846.66, -717.34, 29.29),
        heading = 0.0,
    },
    {
        id = 4,
        name = "Del Perro Beach House",
        basePrice = 180000,
        shell = 1,
        exterior = vector3(-1551.74, -1042.54, 57.0),
        heading = 0.0,
    },
    {
        id = 5,
        name = "Vinewood Mansion",
        basePrice = 350000,
        shell = 2,
        exterior = vector3(650.45, 95.67, 93.21),
        heading = 0.0,
    },
    {
        id = 6,
        name = "Paleto Bay Cottage",
        basePrice = 75000,
        shell = 3,
        exterior = vector3(120.78, 6393.45, 31.93),
        heading = 0.0,
    },
}

-- Job Salary
Config.JobSalary = 500
Config.PaymentInterval = 300000 -- 5 minutes in milliseconds

return Config