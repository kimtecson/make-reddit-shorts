class Title
  def add_text_to_image(image, text, x, y, pointsize, weight = Magick::BoldWeight, color = 'black')
    draw = Magick::Draw.new
    draw.font_family = 'Arial'
    draw.pointsize = pointsize
    draw.font_weight = weight
    draw.fill = color
    draw.gravity = Magick::NorthWestGravity
    draw.annotate(image, 0, 0, x, y, text)
  end

  def overlay_texts_on_image

    image_path = 'app/services/resources/title_template.png'
    output_path = 'app/services/outputs/title_image.png'

    main_text = File.read('app/services/resources/title.txt')
    author_text = "Author Placeholder"

    image = Magick::Image.read(image_path).first



    add_text_to_image(image, author_text, 205, 830, 24)  # Adjust x and y as needed
    add_text_to_image(image, main_text, 205, 940, 36)


    image.write(output_path)
  end
end