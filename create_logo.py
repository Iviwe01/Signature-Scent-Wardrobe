"""
Create a professional logo for Signature Scent Wardrobe app
This script generates launcher icons in various sizes for Android
"""

from PIL import Image, ImageDraw, ImageFont
import os

def create_gradient_background(size, colors):
    """Create a smooth gradient background"""
    image = Image.new('RGB', size)
    draw = ImageDraw.Draw(image)
    
    # Create vertical gradient
    for y in range(size[1]):
        # Interpolate between colors
        ratio = y / size[1]
        r = int(colors[0][0] * (1 - ratio) + colors[1][0] * ratio)
        g = int(colors[0][1] * (1 - ratio) + colors[1][1] * ratio)
        b = int(colors[0][2] * (1 - ratio) + colors[1][2] * ratio)
        draw.line([(0, y), (size[0], y)], fill=(r, g, b))
    
    return image

def create_logo(size, filename):
    """Create a single logo file"""
    # Premium gradient colors (navy to purple)
    color1 = (26, 29, 46)    # Navy #1A1D2E
    color2 = (88, 28, 135)   # Purple #581C87
    
    # Create gradient background
    img = create_gradient_background((size, size), [color1, color2])
    draw = ImageDraw.Draw(img)
    
    # Add rounded rectangle overlay for modern look
    padding = size // 8
    overlay = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    overlay_draw = ImageDraw.Draw(overlay)
    
    # Draw white rounded rectangle with opacity
    rect_coords = [padding, padding, size - padding, size - padding]
    overlay_draw.rounded_rectangle(rect_coords, radius=size//6, fill=(255, 255, 255, 30))
    
    img = Image.alpha_composite(img.convert('RGBA'), overlay)
    
    # Draw perfume bottle icon (simplified elegant design)
    bottle_width = size // 3
    bottle_height = int(size * 0.5)
    bottle_x = (size - bottle_width) // 2
    bottle_y = int(size * 0.25)
    
    # Cap
    cap_height = size // 10
    cap_coords = [
        bottle_x + bottle_width // 4, 
        bottle_y,
        bottle_x + 3 * bottle_width // 4,
        bottle_y + cap_height
    ]
    draw.rounded_rectangle(cap_coords, radius=size//30, fill='#F8F9FA')
    
    # Neck
    neck_width = bottle_width // 2
    neck_height = size // 15
    neck_x = bottle_x + (bottle_width - neck_width) // 2
    neck_coords = [
        neck_x,
        bottle_y + cap_height,
        neck_x + neck_width,
        bottle_y + cap_height + neck_height
    ]
    draw.rectangle(neck_coords, fill='#E5E7EB')
    
    # Main bottle
    bottle_coords = [
        bottle_x,
        bottle_y + cap_height + neck_height,
        bottle_x + bottle_width,
        bottle_y + bottle_height
    ]
    draw.rounded_rectangle(bottle_coords, radius=size//20, fill='#FFFFFF', outline='#E5E7EB', width=max(1, size//100))
    
    # Add sparkle effect (small diamonds)
    sparkle_size = size // 20
    sparkle_positions = [
        (bottle_x - sparkle_size * 2, bottle_y + bottle_height // 3),
        (bottle_x + bottle_width + sparkle_size, bottle_y + bottle_height // 2),
        (bottle_x + bottle_width // 2, bottle_y - sparkle_size)
    ]
    
    for sx, sy in sparkle_positions:
        # Draw small diamond
        sparkle_coords = [
            (sx, sy - sparkle_size // 2),
            (sx + sparkle_size // 2, sy),
            (sx, sy + sparkle_size // 2),
            (sx - sparkle_size // 2, sy)
        ]
        draw.polygon(sparkle_coords, fill='#FCD34D', outline='#F59E0B', width=1)
    
    # Add letter 'S' in the bottle
    if size >= 192:
        try:
            # Try to use a nice font, fall back to default
            font_size = bottle_height // 3
            try:
                font = ImageFont.truetype("arial.ttf", font_size)
            except:
                font = ImageFont.load_default()
            
            text = "S"
            # Get text bbox for centering
            bbox = draw.textbbox((0, 0), text, font=font)
            text_width = bbox[2] - bbox[0]
            text_height = bbox[3] - bbox[1]
            
            text_x = bottle_x + (bottle_width - text_width) // 2
            text_y = bottle_y + cap_height + neck_height + (bottle_height - cap_height - neck_height - text_height) // 2
            
            draw.text((text_x, text_y), text, fill='#581C87', font=font)
        except:
            pass
    
    # Convert back to RGB for saving
    img = img.convert('RGB')
    
    # Save the image
    img.save(filename, 'PNG', quality=100)
    print(f"Created {filename} ({size}x{size})")

def main():
    """Create all required launcher icons"""
    # Android launcher icon sizes
    sizes = {
        'mipmap-mdpi': 48,
        'mipmap-hdpi': 72,
        'mipmap-xhdpi': 96,
        'mipmap-xxhdpi': 144,
        'mipmap-xxxhdpi': 192,
    }
    
    base_path = 'android/app/src/main/res'
    
    # Create icons for each density
    for folder, size in sizes.items():
        folder_path = os.path.join(base_path, folder)
        os.makedirs(folder_path, exist_ok=True)
        
        icon_path = os.path.join(folder_path, 'ic_launcher.png')
        create_logo(size, icon_path)
    
    print("\n✅ All launcher icons created successfully!")
    print("📱 App name: Signature Scent Wardrobe")

if __name__ == '__main__':
    main()
