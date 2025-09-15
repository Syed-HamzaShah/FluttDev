-- Demo Posts for CECOS Hub
-- Copy and paste these into your Supabase SQL Editor

-- Insert demo posts with images
INSERT INTO posts (description, mediaUrl, createdBy, createdByName, createdByAvatar) VALUES


-- Post 2: Library Announcement
(
  '📚 Library Update: Extended hours during exam week! The library will now be open 24/7 from Monday to Friday. Study rooms are available for group sessions. Good luck with your exams!',
  'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800&h=600&fit=crop',
  '550e8400-e29b-41d4-a716-446655440002',
  'Library Services',
  'https://ui-avatars.com/api/?name=Library+Services&size=200&background=059669&color=ffffff'
),

-- Post 3: Coding Club Event
(
  '💻 Coding Club Meeting: Join us this Friday at 3:00 PM in Lab 2 for our weekly coding session. We will be working on Flutter app development. All skill levels welcome!',
  'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800&h=600&fit=crop',
  '550e8400-e29b-41d4-a716-446655440003',
  'Ahmed Hassan',
  'https://ui-avatars.com/api/?name=Ahmed+Hassan&size=200&background=dc2626&color=ffffff'
),

-- Post 4: Sports Event
(
  '⚽ Football Tournament: CECOS Annual Football Championship starts next week! Register your team at the sports office. First match: Monday 2:00 PM at the main ground.',
  'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=800&h=600&fit=crop',
  '550e8400-e29b-41d4-a716-446655440004',
  'Sports Department',
  'https://ui-avatars.com/api/?name=Sports+Dept&size=200&background=ea580c&color=ffffff'
),

-- Post 5: Academic Notice
(
  '📝 Important: Mid-term examinations will be held from March 15-25. Please check your exam schedule on the notice board. Bring your student ID and calculator.',
  'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800&h=600&fit=crop',
  '550e8400-e29b-41d4-a716-446655440005',
  'Academic Office',
  'https://ui-avatars.com/api/?name=Academic+Office&size=200&background=7c3aed&color=ffffff'
),

-- Post 6: Student Achievement
(
  '🏆 Congratulations to Sarah Khan from Computer Science Department for winning the National Programming Competition! She represented CECOS University and secured 1st position. Well done!',
  'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&h=600&fit=crop',
  '550e8400-e29b-41d4-a716-446655440006',
  'Student Affairs',
  'https://ui-avatars.com/api/?name=Student+Affairs&size=200&background=0891b2&color=ffffff'
),

-- Post 7: Workshop Announcement
(
  '🔧 Workshop Alert: "AI and Machine Learning Fundamentals" workshop will be conducted by Dr. Muhammad Ali on Saturday at 10:00 AM in the main auditorium. Limited seats available!',
  'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&h=600&fit=crop',
  '550e8400-e29b-41d4-a716-446655440007',
  'Dr. Muhammad Ali',
  'https://ui-avatars.com/api/?name=Dr+Muhammad+Ali&size=200&background=be185d&color=ffffff'
),

-- Post 8: Campus Life
(
  '🌸 Spring is here! The campus looks beautiful with all the flowers blooming. Perfect weather for outdoor study sessions. Don forget to visit the botanical garden!',
  'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800&h=600&fit=crop',
  '550e8400-e29b-41d4-a716-446655440008',
  'Fatima Ahmed',
  'https://ui-avatars.com/api/?name=Fatima+Ahmed&size=200&background=16a34a&color=ffffff'
),

-- Post 9: Career Guidance
(
  '💼 Career Fair: Top companies including Google, Microsoft, and local tech startups will be visiting campus next month. Prepare your resumes and portfolio. Registration starts Monday!',
  'https://images.unsplash.com/photo-1556761175-b413da4baf72?w=800&h=600&fit=crop',
  '550e8400-e29b-41d4-a716-446655440009',
  'Career Services',
  'https://ui-avatars.com/api/?name=Career+Services&size=200&background=ca8a04&color=ffffff'
),

-- Post 10: Study Tips
(
  '📖 Study Tip: Create a study schedule and stick to it! Break your study sessions into 25-minute intervals with 5-minute breaks. This Pomodoro technique really works!',
  'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800&h=600&fit=crop',
  '550e8400-e29b-41d4-a716-446655440010',
  'Omar Sheikh',
  'https://ui-avatars.com/api/?name=Omar+Sheikh&size=200&background=9333ea&color=ffffff'
),

-- Post 11: Technology Update
(
  '💻 Lab Update: All computer labs have been upgraded with the latest hardware and software. New programming environments and development tools are now available for students.',
  'https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=800&h=600&fit=crop',
  '550e8400-e29b-41d4-a716-446655440011',
  'IT Department',
  'https://ui-avatars.com/api/?name=IT+Department&size=200&background=0d9488&color=ffffff'
),

-- Post 12: Cultural Event
(
  '🎭 Cultural Week: Join us for the annual cultural week starting next Monday! Music, drama, poetry, and art competitions. Show your talent and win exciting prizes!',
  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&h=600&fit=crop',
  '550e8400-e29b-41d4-a716-446655440012',
  'Cultural Society',
  'https://ui-avatars.com/api/?name=Cultural+Society&size=200&background=dc2626&color=ffffff'
);

-- Verify the posts were inserted
SELECT COUNT(*) as total_posts FROM posts;
