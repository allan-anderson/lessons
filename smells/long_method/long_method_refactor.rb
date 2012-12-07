def survey_results
  @start_date = Date.parse("12/10/02")
  @date = @start_date + params[:id].to_i.weeks
  @csv_file = File.read(Rails.root.join("uploads", "surveys", "how_going_#{params[:id]}.csv"))
  @responses = process_csv(@csv_file)
  @questions_text = get_questions_text(@csv_file)
end

def get_questions_text(csv_file)
  questions_text = ''
  CSV.parse(csv_file) do |row|
    @data = {}
    if n == 0
      questions_text = [ row[6], row[7], row[8] ]
      n = 0
    else
      next if n > 0 
    end
    n += 1
  end
  questions_text
end

def process_csv(csv_file)
  responses = []
  n = 0
  errs = 0, []
  CSV.parse(csv_file) do |row|
   data = {}
    if n == 0
      @questions_text = [ row[6], row[7], row[8] ]
    else
      next if row.join.blank?
      responses = proocess_row(row)
    end
    n += 1
  end
  responses
end

def process_row(row)
  @data[:mood] = { question_type: "num", answer: row[1] }
  @data[:mood_why] = { question_type: "text_long", answer: row[2] }
  user = User.find_by_email(row[3]).blank? ? row[3] : User.find_by_email(row[3])
  @data[:email] = { question_type: "email", answer: user}
  @data[:visibility] = { question_type: "visibility", answer: row[4].downcase == "visible" ? true : false }
  @data[:week_short] = { question_type: "text_short", answer: row[5] }
  @data[:questions_1] = { question_type: "yes_no", answer: row[6]}
  @data[:questions_2] = { question_type: "yes_no", answer: row[7]}
  @data[:questions_3] = { question_type: "text_short", answer: row[8] }
  @data[:comments] = { question_type: "text_short", answer: row[9] }
end
