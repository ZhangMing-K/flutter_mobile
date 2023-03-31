import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/pages.dart';
import '../../../components/onboarding_wrapper.dart';
import '../controllers/user_experience_controller.dart';

class UserExperienceScreen extends GetView<UserExperienceController> {
  const UserExperienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnboardingWrapper(
      child: ListView(
        children: [
          Container(
              margin:
                  EdgeInsets.symmetric(horizontal: IrisScreenUtil.dWidth(15)),
              child: Text(
                'What is your investing experience?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: IrisScreenUtil.dFontSize(24),
                    fontWeight: FontWeight.w700),
              )),
          SizedBox(
            height: IrisScreenUtil.dWidth(80),
          ),
          ExperienceCard(
            onTap: () {
              controller.setExperienceLevel(EXPERIENCE_LEVEL.BEGINNER);
            },
            title: 'Beginner',
            description:
                'You are early in your investing career and don’t have any favorite stocks or strategies.',
          ),
          ExperienceCard(
            onTap: () {
              controller.setExperienceLevel(EXPERIENCE_LEVEL.INTERMEDIATE);
            },
            title: 'Intermediate',
            description:
                'You have been investing for some time and have some preferred stocks or strategies.',
          ),
          ExperienceCard(
            onTap: () {
              controller.setExperienceLevel(EXPERIENCE_LEVEL.ADVANCED);
            },
            title: 'Advanced',
            description:
                'You like to use option strategies, actively trade assets or have a solid understanding of the markets.',
          ),
        ],
      ),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    Key? key,
    required this.title,
    required this.onTap,
    required this.description,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;
  final String description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: IrisScreenUtil.dHeight(136),
        margin: EdgeInsets.all(IrisScreenUtil.dWidth(12)),
        padding: EdgeInsets.all(IrisScreenUtil.dWidth(16)),
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.secondary.withOpacity(.15),
          borderRadius: kBorderRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: IrisScreenUtil.dFontSize(24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.chevron_right)
              ],
            ),
            SizedBox(height: IrisScreenUtil.dWidth(16)),
            Text(
              description,
              style: TextStyle(
                fontSize: IrisScreenUtil.dFontSize(16),
                color: context.theme.colorScheme.secondary.withOpacity(.6),
              ),
            )
          ],
        ),
      ),
    );
  }
}
