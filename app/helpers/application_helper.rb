module ApplicationHelper
	def title
		base_title ="Ruby on Rails Tutorial sample app"
		if title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end

	def logo
		image_tag("logo.png", :alt => "sample App" , :class => "round" )
	end
end

