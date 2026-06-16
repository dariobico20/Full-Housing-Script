# Full Housing Script

A comprehensive FiveM housing script with real estate job, multiple house shells, and a complete decoration system.

## Features

✅ **Real Estate Job** - Become a Real Estate Agent
✅ **Multiple House Shells** - 3 different interior designs
✅ **House Purchasing** - Set custom prices based on shell type
✅ **Decoration System** - 10+ furniture items to customize your home
✅ **House Selling** - Sell your house back on the market
✅ **Empty Shells** - All houses start empty and customizable

## House Shells

1. **Modern Apartment** - 1.0x price multiplier
2. **Luxury Penthouse** - 1.5x price multiplier
3. **Stylish Loft** - 1.2x price multiplier

## Available Decorations

- Leather Sofa - $500
- Wooden Table - $300
- Computer Desk - $800
- Bathroom Vanity - $400
- Bed Frame - $1200
- Kitchen Counter - $600
- Floor Lamp - $200
- Plant Pot - $150
- Bookshelf - $700
- TV Stand - $1000

## Commands

```
/house              - Open housing menu
/browse             - Browse all available houses
/buyhouse [number]  - Purchase a house
/enterhouse         - Enter your house
/exithouse          - Exit your house
/decorate           - Open decoration menu
/placeitem [number] - Place a decoration item
/removeitem [number]- Remove a decoration item
/sellhouse          - Sell your house
/houseinfo [number] - View house information
/houses             - List all houses
```

## Installation

1. Download the script
2. Place in your `resources` folder
3. Add `ensure Full-Housing-Script` to your `server.cfg`
4. Restart your server

## Default Houses

1. **Pillbox Apartment** - $50,000 (Modern Apartment)
2. **Downtown Penthouse** - $150,000 (Luxury Penthouse)
3. **Rockford Hills Estate** - $250,000 (Stylish Loft)
4. **Del Perro Beach House** - $180,000 (Modern Apartment)
5. **Vinewood Mansion** - $350,000 (Luxury Penthouse)
6. **Paleto Bay Cottage** - $75,000 (Stylish Loft)

## Configuration

Edit `shared/config.lua` to customize:
- House locations and prices
- Available decoration items
- House shell types
- Job salary and payment intervals

## Features

### Real Estate Job
- Players can work as real estate agents
- Receive salary payments
- Sell houses to other players

### House Purchasing
- Choose from 6 available houses
- Each shell type has different pricing
- Prices are calculated based on shell multiplier

### Decoration System
- Empty shells to start
- Place multiple decorations in your house
- Save decorations to database
- Remove decorations as needed
- Full 3D object placement

## Notes

- All houses start empty
- Decorations are saved per house
- Prices are calculated dynamically based on shell type
- Server-side validation prevents exploiting

## Support

For issues or suggestions, please create an issue on GitHub.

---

**Made with ❤️ by dariobico20**