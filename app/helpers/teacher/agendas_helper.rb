module Teacher::AgendasHelper
  def qualified_classroom_name classroom
    [classroom.school.name,
     classroom.school_class.name,
     classroom.name].join ' > '
  end
end
