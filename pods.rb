

students = ["Brinn Cheney",
"Chris Spicer",
"Chris Bitoye",
"Dagm Zerfu",
"Darren Perry",
"David Lashinsky",
"Erin Van Brunt",
"Gabriel Bustos Flores",
"Gabriel De Moura",
"Henry McDonald",
"Ian Stewart",
"Joshua Compton",
"Kathy Chu",
"Louisa Johnston",
"Mariia Melnikova",
"Nakisha Bryant",
"Sarah Marie Coogan",
"Semuel St.Aubin",
"Justin Park",
"Sunil Lama",]

u1 = {
  'Pete' => [
    "Joshua Compton",
    "Justin Park",
    "Semuel St.Aubin",
    "Sarah Marie Coogan",
    "Mariia Melnikova",
    "Gabriel De Moura",
    "Louisa Johnston",
  ],
  'Weston' => [
    "Henry McDonald",
    "Erin Van Brunt",
    "Ian Stewart",
    "Dagm Zerfu",
    "Darren Perry",
    "Kathy Chu",
    "Gabriel Bustos Flores",
  ],
  'Henry' => [
    "David Lashinsky",
    "Chris Bitoye",
    "Chris Spicer",
    "Brinn Cheney",
    "Nakisha Bryant",
    "Sunil Lama",
  ]
}

student_pod_sequences = {}

u1.each do |pod_leader, students|
  students.each do |s|
    student_pod_sequences[s] = { '1' => pod_leader}
  end
end


def student_counts_for_unit(unit, sps)
  output = {}

  sps.each do |student, sequence|
    output[sequence[unit]] ||= 0
    output[sequence[unit]] += 1
  end
  
  output
end

def max_diff(counts)
  counts.map do |c|
    c.values.max - c.values.min
  end.max
end


def pods_for_unit(unit, sps)
  output = {}

  sps.each do |student, sequence|
    output[sequence[unit]] ||= []
    output[sequence[unit]] << student
  end

  output
end

 
student_pod_sequences.each do |s, sequence|
  leaders = u1.keys.shuffle.reject {|l| l == sequence['1'] }
  sequence['2'] = leaders[0]
  sequence['3'] = leaders[1]
end

counts = %w(1 2 3).map {|u| student_counts_for_unit(u, student_pod_sequences)}

while max_diff(counts) > 1 do
  student_pod_sequences.each do |s, sequence|
    leaders = u1.keys.shuffle.reject {|l| l == sequence['1'] }
    sequence['2'] = leaders[0]
    sequence['3'] = leaders[1]
  end
  
  counts = %w(1 2 3).map {|u| student_counts_for_unit(u, student_pod_sequences)}
end


%w(1 2 3).each do |unit|
  puts "\nProject ##{unit}:"
  puts pods_for_unit(unit, student_pod_sequences)
end





