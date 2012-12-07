def survey_results
  @start_date = Date.parse("12/10/02")
  @date = @start_date + params[:id].to_i.weeks

  @csv_file = File.read(Rails.root.join("uploads", "surveys", "how_going_#{params[:id]}.csv"))

  @responses = []
  @questions_text =[]

  process_csv(@responses, @questions_text)
end

def process_csv(responses, questions_text)
  CSV.parse(@csv_file).each_with_index do |row, index|
    if row == 0
      @questions_text << [ row[6], row[7], row[8] ]
    elsif index > 0 && !row.join.blank?
      @responses << process_row(row) 
    end
  end
end

def process_row(row)
  data = {}
  data[:mood] = { question_type: "num", answer: row[1] }
  data[:mood_why] = { question_type: "text_long", answer: row[2] }
  user = User.find_by_email(row[3]).blank? ? row[3] : User.find_by_email(row[3])
  data[:email] = { question_type: "email", answer: user}
  data[:visibility] = { question_type: "visibility", answer: row[4].downcase == "visible" ? true : false }
  data[:week_short] = { question_type: "text_short", answer: row[5] }
  data[:questions_1] = { question_type: "yes_no", answer: row[6]}
  data[:questions_2] = { question_type: "yes_no", answer: row[7]}
  data[:questions_3] = { question_type: "text_short", answer: row[8] }
  data[:comments] = { question_type: "text_short", answer: row[9] }
  data
end
