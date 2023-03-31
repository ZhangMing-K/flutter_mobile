import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/profile/modules/summary/views/widgets/percent_display.dart';
import 'package:iris_mobile/app/routes/pages.dart';

import '../../../../institution/classes/connect_institution_arts.dart';

///TODO needs work. as follows:
/// Has hard coded values throughout. use test_Data.dart, or (if available) plug into real data
/// rounded check icon has a white border in dark mode. not supposed to.
/// the select list should not display the check mark if it is not open
/// (perhaps combining all three 'SelectionItem' widgets at the bottom could allow use of the selected Item builder?)
class PortfolioSelector extends StatelessWidget {
  const PortfolioSelector({
    Key? key,
    required this.user,
    required this.selectedPortfolio,
    required this.onSelected,
    required this.portfolios,
    required this.isAuthUser,
    required this.onConnect,
  }) : super(key: key);
  final User user;
  final int? selectedPortfolio;
  final ValueSetter<int?> onSelected;
  final List<Portfolio> portfolios;
  final bool isAuthUser;
  final VoidCallback onConnect;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12)),
        child: DropdownButton<int>(
          itemHeight: 52,
          icon: Container(
            margin: const EdgeInsets.only(right: 14),
            child: RotatedBox(
                quarterTurns: 3,
                child: Icon(
                  Icons.chevron_left,
                  size: 30,
                  color: context.theme.colorScheme.secondary,
                )),
          ),
          isExpanded: true,
          borderRadius: BorderRadius.circular(12),
          dropdownColor: Theme.of(context).cardColor,
          underline: Container(),
          // selectedItemBuilder: , //TODO use this to build the row with out a checkbox?
          items: [
            DropdownMenuItem(
              value: null,
              onTap: () {
                onSelected(null);
              },
              child: _AllPortfolioSelectionItem(
                user: user,
                selected: selectedPortfolio == null,
              ),
            ),
            ...portfolios
                .map((p) => DropdownMenuItem(
                      onTap: () {
                        onSelected(p.portfolioKey!);
                      },
                      value: p.portfolioKey,
                      child: _PortfolioSelectionItem(
                        portfolio: p,
                        selected: selectedPortfolio == p.portfolioKey,
                      ),
                    ))
                .toList(),
            if (isAuthUser)
              DropdownMenuItem(
                value: 0,
                child: const AddPortfolioSelectionItem(),
                onTap: () async {
                  var args = ConnectInstitutionArgs(
                      from: INSTITUTION_CONNECTED_FROM.PROFILE);
                 await Get.toNamed(Paths.InstitutionConnectLanding, arguments: args);

                  onConnect();

                  /// TODO not working
                  /// logs when clicked:
                  /// [GETX] GOING TO ROUTE /instiution-connect-landing
                  /// [GETX] GOING TO ROUTE /instiution-connect-landing
                  /// [GETX] CLOSE TO ROUTE /instiution-connect-landing
                  /// [GETX] CLOSE TO ROUTE /instiution-connect-landing
                },
              ),
          ],
          onChanged: (value) {},
          value: selectedPortfolio,
        ),
      ),
    );
  }
}

class _AllPortfolioSelectionItem extends StatelessWidget {
  const _AllPortfolioSelectionItem({
    Key? key,
    required this.user,
    required this.selected,
  }) : super(key: key);

  final User user;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          AbsorbPointer(
            child: UserImage(
              user: user,
              radius: 11,
              hasHero: false,
              showStories: false,
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            'All Portfolios',
            style: Theme.of(context).textTheme.headline6,
          ),
          //  Text(' (${user.portfolios?.length ?? 0})'),
          const SizedBox(
            width: 2,
          ),
          //TODO get a real value from the backend. Currently do not know where to obtain an aggregate performance percentage for all portfolios
          // PercentDisplay(
          //   percent: user.temporarySnapshotHistoricalPoints?.yearPercent ?? 0.0,
          //   showDecimal: false,
          // ),
          // const Spacer(),
          // _CircleCheck(selected: selected),
        ],
      ),
    );
  }
}

class _CircleCheck extends StatelessWidget {
  const _CircleCheck({Key? key, this.selected = false}) : super(key: key);
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: selected ? Colors.white : Colors.transparent,
        ),
        child: selected
            //TODO this selected checkmark has a white border. get rid of it to match designs
            ? Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              )
            : const Icon(Icons.circle_outlined));
  }
}

class _PortfolioSelectionItem extends StatelessWidget {
  const _PortfolioSelectionItem({
    Key? key,
    required this.portfolio,
    required this.selected,
  }) : super(key: key);

  final Portfolio portfolio;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BrokerIcon(brokerName: portfolio.brokerName, height: 24),
          const SizedBox(width: 8.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    portfolio.portfolioName ?? portfolio.brokerName.toString(),
                    style: TextStyle(
                      color: context.theme.colorScheme.secondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  PercentDisplay(
                      //TODO move off of the snapshot, and onto the field aaron L. is adding called 'temporaryHistoricalData' or something like that
                      percent: portfolio.snapshot?.yearPercent,
                      showDecimal: false),
                ],
              ),
              //TODO get and display the actual last sync date for the give portfolio
              Text(
                'last synced ${portfolio.snapshot?.lastUpdatedFrom}',
                style: TextStyle(
                  color: context.theme.colorScheme.secondary.withOpacity(.5),
                  fontSize: 14,
                ),
              )
            ],
          ),
          const Spacer(),
          _CircleCheck(selected: selected),
        ],
      ),
    );
  }
}

class AddPortfolioSelectionItem extends StatelessWidget {
  const AddPortfolioSelectionItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: Theme.of(context).custom.colorScheme.primaryBlue,
                borderRadius: BorderRadius.circular(4.0)),
            child: Icon(Icons.add,
                color: Theme.of(context).custom.colorScheme.onPrimaryBlue),
          ),
          const SizedBox(width: 8.0),
          const Text('Add a portfolio'),
          const Spacer(),
          const Icon(Icons.add)
        ],
      ),
    );
  }
}
